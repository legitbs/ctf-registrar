class Challenge < ActiveRecord::Base
  belongs_to :category
  has_many :solutions
  has_many :solution_histograms
  has_many :observations

  def self.for_scoreboard(team)
    challenge_rows = connection.select_all <<-SQL
      SELECT
        c.id as challenge_id,
        a.name as category_name,
        c.name as challenge_name,
        round(c.calc_points, 0) as points,
        s.created_at,
        c.unlocked_at,
        c.solved_at
      FROM
        scored_challenges AS c
        INNER JOIN categories AS a
          ON c.category_id = a.id
        LEFT JOIN solutions AS s
          ON c.id = s.challenge_id and s.team_id=#{team.id.to_i}
      ORDER BY
        a.order ASC,
        c.points ASC,
        c.name ASC
    SQL

    challenge_rows.group_by{|r| r['category_name']}.values
  end

  def self.unscored_for_scoreboard(team)
    challenge_rows = connection.select_all <<-SQL
      SELECT
        c.id as challenge_id,
        a.name as category_name,
        c.name as challenge_name,
        c.points,
        s.created_at,
        c.unlocked_at,
        c.solved_at
      FROM
        challenges AS c
        INNER JOIN categories AS a
          ON c.category_id = a.id
        LEFT JOIN solutions AS s
          ON c.id = s.challenge_id and s.team_id=#{team.id.to_i}
      ORDER BY
        a.order ASC,
        c.points ASC,
        c.name ASC
    SQL

    challenge_rows.group_by{|r| r['category_name']}.values
  end

  def self.for_picker(team)
    challenges = unscored_for_scoreboard team

    category_min_unsolved = Category.all.inject({  }) do |mem, cat|
      mem[cat.name] = cat.challenges.where(solved_at: nil).map(&:points).compact.min || 1
      mem
    end

    challenges.flatten.each do |c|
      max_unlock = category_min_unsolved[c['category_name']]
      next c['class'] = 'solved' if c['created_at']
      next c['class'] = 'live' if c['unlocked_at']
      next c['class'] = 'locked' if c['points'].to_i > max_unlock
      c['class'] = 'burning'
    end

    return challenges
  end

  def scored
    ScoredChallenge.find_by id: self.id
  end

  def as_json(args)
    super args.merge(
            except: %i{answer_digest created_at updated_at},
            methods: :plural_points
          )
  end

  def plural_points
    points > 1
  end

  def locked?
    unlocked_at.nil?
  end

  def unlock!
    self.class.where(id: id, unlocked_at: nil).update_all(unlocked_at: Time.now)
  end

  def lock!
    update_attribute :unlocked_at, nil
  end

  def answer
    ''
  end

  def answer=(val)
    return if val.blank?
    self.answer_digest = BCrypt::Password.create val
  end

  def correct_answer?(candidate)
    BCrypt::Password.new(answer_digest) == candidate
  end

  def solve!
    count = self.class.where(id: id, solved_at: nil).update_all(solved_at: Time.now)
    return count == 1
  end

  def view!(user)
    REDIS.incr views_key
    Observation.observe! self, user
  end

  def views
    REDIS.get(views_key).to_i
  end

  def views_key
    "challenge-#{id}-views"
  end

  def solution_stats
    self.class.connection.select_one(<<-SQL)
      SELECT
        s.challenge_id AS challenge_id,
        COUNT(s.challenge_id),
        AVG(EXTRACT(epoch FROM s.created_at - o.created_at)),
        STDDEV(EXTRACT(epoch FROM (s.created_at - o.created_at)))
      FROM solutions AS s
      RIGHT JOIN observations AS o ON
        o.team_id = s.team_id AND o.challenge_id = s.challenge_id
      WHERE s.challenge_id=#{id.to_i}
      GROUP BY s.challenge_id
    SQL
  end
end
