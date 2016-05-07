class RefreshViewsConcurrently < ActiveRecord::Migration
  def up
    add_index :scoreboard, :team_id, unique: true
    add_index :solution_histogram, %i{challenge_id end_time}, unique: true

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

    Solution.connection.execute <<-SQL
      CREATE OR REPLACE FUNCTION solution_histogram_refresh_proc()
      RETURNS trigger AS
      $$
      BEGIN
        REFRESH MATERIALIZED VIEW CONCURRENTLY solution_histogram;
        RETURN new;
      END;
      $$
      LANGUAGE plpgsql
    SQL

    Team.connection.execute "REFRESH MATERIALIZED VIEW CONCURRENTLY scoreboard"
    Solution.connection.execute <<-SQL
      REFRESH MATERIALIZED VIEW CONCURRENTLY solution_histogram;
    SQL
  end
end
