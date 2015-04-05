class Team < ActiveRecord::Base
  belongs_to :user

  has_secure_password

  validates :name, presence: true, uniqueness: true, length: {minimum: 3, maximum: 60}
  validates :user, presence: true

  has_many :solutions
  has_many :challenges, through: :solutions
  has_many :awards
  has_many :achievements, through: :awards
  has_many :members, class_name: 'User'
  has_many :notices

  has_attached_file :logo
  validates_attachment(:logo,
                       content_type: { content_type: /\Aimage/ },
                       size: { in: 0..128.kilobytes }
                      )

  def score
    solutions.joins(:challenge).sum('challenges.points')
  end

  def solution_for(challenge)
    solutions.where(challenge_id: challenge.id).first_or_initialize
  end

  def self.entire_scoreboard
    connection.select_all(<<-SQL).to_a
      SELECT
        t.id AS team_id,
        t.name AS team_name,
        SUM(c.points) AS score,
        MAX(s.created_at) AS last_solution_time
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
    SQL
  end

  def self.anonymous_scoreboard
    connection.select_all(<<-SQL).to_a
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
      WHERE
        team_id != 1
      GROUP BY t.id
      ORDER BY
        score DESC,
        MAX(s.created_at) ASC,
        MAX(s.id) ASC
      LIMIT 25
    SQL
  end

  def self.for_scoreboard(current_team)
    scoreboard_rows = anonymous_scoreboard

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

  def self.average_size
    connection.select_all(<<-SQL).to_a.first.values.first.to_f
      SELECT
        avg(count)
      FROM (
        SELECT
          COUNT(team_id) AS count
        FROM users
        WHERE
          team_id IS NOT NULL
        GROUP BY team_id)
      AS c
    SQL
  end

  def self.search(text)
    where "to_tsvector('english', name) @@ to_tsquery('english', ?)", text
  end
end
