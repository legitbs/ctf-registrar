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
end
