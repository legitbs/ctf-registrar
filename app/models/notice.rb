class Notice < ActiveRecord::Base
  belongs_to :team
  attr_accessible :body

  def self.for(team, since=nil)
    since ||= 0
    where(
          '(created_at > :since) and (team_id is null or team_id = :team_id)', 
          since: Time.at(since.to_i + 0.4),
          team_id: team.id)
  end

  def as_json(*args)
    super only: %i{body created_at team_id}
  end
end
