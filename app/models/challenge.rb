class Challenge < ActiveRecord::Base
  belongs_to :category
  has_many :solutions
  attr_accessible :answer_digest, :clue, :name, :points

  def self.for_scoreboard(team)
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
        c.points ASC,
        a.order ASC
    SQL

    challenge_rows.group_by{|r| r['points']}.values
  end

  def as_json(args)
    super args.merge except: %i{answer_digest created_at updated_at}
  end

  def locked?
    unlocked_at.nil?
  end

  def unlock!
    self.class.where(id: id, unlocked_at: nil).update_all(unlocked_at: Time.now)
  end

  def answer
    BCrypt::Password.new answer_digest
  end

  def correct_answer?(candidate)
    answer == candidate
  end

  def solve!
    count = self.class.where(id: id, solved_at: nil).update_all(solved_at: Time.now)
    return count == 1
  end
end
