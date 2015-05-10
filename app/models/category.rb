class Category < ActiveRecord::Base
  has_many :challenges
  validates :name, uniqueness: true

  def self.for_scoreboard
    connection.select_rows <<-SQL
      SELECT c.id, c.name
      FROM categories as c
      ORDER BY c.id asc
      SQL
  end

  def self.for_picker
    rows = connection.select_all <<-SQL
      SELECT
        c.id AS category_id,
        c.name,
        a.points,
        a.id as challenge_id
      FROM categories AS c
      RIGHT JOIN challenges AS a ON a.category_id = c.id
      WHERE
        a.solved_at IS NULL
      ORDER BY
        a.points ASC,
        c.order ASC
    SQL

    min_point = rows.first['points']

    collector = Hash.new
    rows.each do |r|
      next if collector[r['category_id']]
      collector[r['category_id']] = r
    end

    return collector
  end
end
