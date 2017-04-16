class Team < ActiveRecord::Base
  belongs_to :user

  has_secure_password

  validates :name,
            presence: true,
            uniqueness: true,
            length: {minimum: 3, maximum: 60}
  validates :user, presence: true

  has_many :solutions
  has_many :challenges, through: :solutions
  has_many :awards
  has_many :achievements, through: :awards
  has_many :members, class_name: 'User'
  has_many :notices
  has_many :observations

  has_attached_file(:logo,
                    default_url: 'missing-64x64.png',
                    fog_directory: 'teams-2017.legitbs.net',
                    fog_host: 'https://teams-2017.legitbs.net',
                    styles: {
                      thumb: '64x64#',
                      badge: '160x120',
                      medium: '256x256',
                      large: '512x512'
                    },
                    hash_secret: 'cats',
                    hash_data: "production/:class/:attachment/:id/:style/:updated_at",
                    url: 'https://teams-2017.legitbs.net/t/:hash.:extension',
                    path: 't/:hash.:extension',
                   )
  validates_attachment(:logo,
                       content_type: { content_type: ["image/jpeg",
                                                      "image/gif",
                                                      "image/png"] },
                       size: { in: 0..128.kilobytes }
                      )

  def score
    self.class.connection.select_value(<<-SQL)
      SELECT round(sum(calc_points), 0) FROM scored_challenges AS c
      INNER JOIN solutions AS s ON s.challenge_id = c.id
      WHERE s.team_id=#{id}
    SQL
  end

  def solution_for(challenge)
    solutions.where(challenge_id: challenge.id).first_or_initialize
  end

  def as_redis
    {
      id: id,
      name: name,
      logo: logo.url(:thumb)
    }
  end

  def display_name
    self.display || self.name
  end

  def self.entire_scoreboard
    connection.select_all(<<-SQL).to_a
      SELECT * from scoreboard ORDER BY score DESC, last_solve ASC, team_id ASC
    SQL
  end

  def self.anonymous_scoreboard
    connection.select_all(<<-SQL).to_a
      SELECT * from scoreboard  ORDER BY score DESC, last_solve ASC, team_id ASC LIMIT 25
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
        'display_name' => current_team.display_name,
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
