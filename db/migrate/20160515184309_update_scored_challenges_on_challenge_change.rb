class UpdateScoredChallengesOnChallengeChange < ActiveRecord::Migration
  def up
    Solution.connection.execute <<-SQL
      CREATE TRIGGER scored_challenges_update_on_challenge_change
        AFTER INSERT OR UPDATE ON challenges
        FOR EACH STATEMENT
        EXECUTE PROCEDURE scored_challenges_refresh_proc();
    SQL
  end

  def down
    Solution.connection.execute <<-SQL
      DROP TRIGGER scored_challenges_update_on_challenge_change;
    SQL
  end
end
