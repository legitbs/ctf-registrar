class ScoreboardMatviewUsesScoredChallenges < ActiveRecord::Migration
  def change
    Team.connection.execute "DROP MATERIALIZED VIEW IF EXISTS scoreboard"

    Team.connection.execute <<-SQL
      CREATE MATERIALIZED VIEW scoreboard AS
      SELECT
        t.id AS team_id,
        (CASE WHEN (t.display IS NULL or t.display = '')
          THEN t.name
          ELSE t.display
          END) AS team_name,
        round(SUM(c.calc_points), 0) AS score,
        MAX(s.created_at) AS last_solve
      FROM
        teams AS t
        INNER JOIN solutions AS s
          ON s.team_id = t.id
        INNER JOIN scored_challenges AS c
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
      CREATE UNIQUE INDEX ON scoreboard (team_id)
    SQL

    Team.connection.execute <<-SQL
      CREATE OR REPLACE FUNCTION scoreboard_refresh_proc() RETURNS trigger AS
      $$
      BEGIN
        REFRESH MATERIALIZED VIEW CONCURRENTLY scoreboard;
        RETURN new;
      END;
      $$
      LANGUAGE plpgsql
    SQL

    Team.connection.execute "REFRESH MATERIALIZED VIEW CONCURRENTLY scoreboard"
  end
end
