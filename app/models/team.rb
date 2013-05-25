class Team < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :password

  has_secure_password

  validates :name, presence: true, uniqueness: true, length: {minimum: 4, maximum: 60}

  has_many :solutions

  def self.for_scoreboard(current_team)
    scoreboard_rows = connection.select_all <<-SQL
      SELECT
        t.id AS team_id,
        t.name AS team_name, 
        SUM(c.points) AS score 
      FROM
        teams AS t
        INNER JOIN solutions AS s 
          ON s.team_id = t.id
        INNER JOIN challenges AS c 
          ON s.challenge_id = c.id
      GROUP BY t.id
      ORDER BY score DESC
      LIMIT 25
    SQL

    if (found = scoreboard_rows.detect { |r| r['team_id'] == current_team.id.to_s })
      found['current'] = true
    else
      scoreboard_rows << {
        'team_id' => current_team.id, 
        'team_name' => current_team.name, 
        'score' => current_team.score,
        'current' => true}
    end

    return scoreboard_rows
  end

  def score
    solutions.joins(:challenge).sum('challenges.points')
  end
end
