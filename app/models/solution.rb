class Solution < ActiveRecord::Base
  belongs_to :team
  belongs_to :challenge

  validates :team_id, uniqueness: {scope: :challenge_id}

  attr_accessor :answer

  def as_redis
    {
      team: team.as_redis,
      challenge: challenge.as_json({  }),
      category: challenge.category.as_json
    }
  end
end
