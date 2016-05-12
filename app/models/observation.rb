class Observation < ActiveRecord::Base
  belongs_to :team
  belongs_to :challenge
  belongs_to :user

  def self.observe!(challenge, user)
    connection.insert <<-SQL
      INSERT INTO #{table_name}
      (team_id, challenge_id, user_id, created_at, updated_at)
      VALUES (#{user.team_id.to_i},
              #{challenge.id.to_i},
              #{user.id.to_i},
              NOW(),
              NOW())
      ON CONFLICT DO NOTHING
    SQL
  end

  def solution
    Solution.find_by(team_id: team_id, challenge_id: challenge_id)
  end
end
