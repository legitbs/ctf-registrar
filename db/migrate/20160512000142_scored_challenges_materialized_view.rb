class ScoredChallengesMaterializedView < ActiveRecord::Migration
  def change
    Challenge.connection.execute <<-SQL
      CREATE MATERIALIZED VIEW scored_challenges AS
      SELECT
        c.*,
        (5000 * (1.0 / (count(s.challenge_id) + 11.5))) + 1 as calc_points,
        count(s.challenge_id) as solve_count
      FROM challenges AS c
      LEFT JOIN solutions AS s
        ON c.id = s.challenge_id
      GROUP BY c.id
    SQL

    add_index :scored_challenges, :id, unique: true

    Challenge.connection.execute <<-SQL
      CREATE OR REPLACE FUNCTION scored_challenges_refresh_proc()
      RETURNS trigger AS
      $$
      BEGIN
        REFRESH MATERIALIZED VIEW CONCURRENTLY scored_challenges;
        RETURN new;
      END;
      $$
      LANGUAGE plpgsql
    SQL

    Solution.connection.execute <<-SQL
      CREATE TRIGGER scored_challenges_update_trigger
        AFTER INSERT ON solutions
        FOR EACH STATEMENT
        EXECUTE PROCEDURE scored_challenges_refresh_proc();
    SQL

    Team.connection.execute <<-SQL
      REFRESH MATERIALIZED VIEW CONCURRENTLY scored_challenges
    SQL
  end
end
