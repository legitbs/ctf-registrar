class ScorebaordMaterializedView < ActiveRecord::Migration
  def up
    Team.connection.execute <<-SQL
      CREATE MATERIALIZED VIEW scoreboard AS
      SELECT
        t.id AS team_id,
        t.name AS team_name,
        SUM(c.points) AS score,
        MAX(s.created_at) AS last_solve
      FROM
        teams AS t
        INNER JOIN solutions AS s
          ON s.team_id = t.id
        INNER JOIN challenges AS c
          ON s.challenge_id = c.id
      WHERE
        team_id != 1
      GROUP BY t.id
      ORDER BY
        score DESC,
        MAX(s.created_at) ASC,
        MAX(s.id) ASC
      WITH DATA
    SQL

    Team.connection.execute <<-SQL
      CREATE OR REPLACE FUNCTION scoreboard_refresh_proc() RETURNS trigger AS
      $$
      BEGIN
        REFRESH MATERIALIZED VIEW CONCURRENTLY scoreboard;
      END;
      $$
      LANGUAGE plpgsql
    SQL

    Team.connection.execute <<-SQL
      CREATE TRIGGER scoreboard_update_trigger
        AFTER INSERT ON solutions
        FOR EACH STATEMENT
        EXECUTE PROCEDURE scoreboard_refresh_proc();
    SQL
  end

  def down
    Team.connection.execute "DROP TRIGGER IF EXISTS scoreboard_update_trigger ON solutions"
    Team.connection.execute "DROP FUNCTION IF EXISTS scoreboard_refresh_proc"
    Team.connection.execute "DROP MATERIALIZED VIEW IF EXISTS scoreboard"
  end
end
