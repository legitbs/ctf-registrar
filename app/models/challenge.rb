class Challenge < ActiveRecord::Base
  belongs_to :category
  attr_accessible :answer_digest, :clue, :name, :points

  def self.for_scoreboard(team)
    challenge_rows = connection.select_all <<-SQL
      SELECT
        a.name as category_name,
        c.name as challenge_name,
        c.points,
        s.created_at
      FROM
        challenges AS c
        INNER JOIN categories AS a
          ON c.category_id = a.id
        LEFT JOIN solutions AS s
          ON c.id = s.challenge_id and s.team_id=#{team.id.to_i}
      ORDER BY
        c.points asc,
        a.id asc
    SQL

    challenge_rows.group_by{|r| r['points']}.values
  end
end
