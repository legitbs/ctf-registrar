class Notice < ActiveRecord::Base
  belongs_to :team

  def self.for(team, since=nil)
    since ||= 0
    where(
          '(created_at > :since) and (team_id is null or team_id = :team_id)',
          since: Time.at(since.to_i + 1),
          team_id: team.id)
      .order(created_at: :asc)
  end

  def self.search(text)
    where "to_tsvector('english', body) @@ to_tsquery('english', ?)", text
  end

  def as_json(*args)
    super only: %i{body created_at team_id}
  end

  def tweet
    true
  end

  def post
    true
  end
end
