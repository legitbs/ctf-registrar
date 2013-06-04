class Category < ActiveRecord::Base
  attr_accessible :name, :order
  has_many :challenges

  def self.for_scoreboard
    connection.select_rows <<-SQL
      SELECT c.id, c.name
      FROM categories as c
      ORDER BY c.id asc
      SQL
  end

  def self.for_picker
    connection.select_rows <<-SQL
      SELECT 
        c.id, 
        c.name, 
        c.order, 
        COUNT(a.id)
      FROM categories AS c
      RIGHT JOIN challenges AS a 
        ON a.category_id = c.id
      WHERE a.unlocked_at IS NULL
      GROUP BY c.id
    SQL
  end
end
