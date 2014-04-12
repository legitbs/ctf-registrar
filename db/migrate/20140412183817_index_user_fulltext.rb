class IndexUserFulltext < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE INDEX 
        users_fulltext 
      ON 
        users 
      USING 
        gin(to_tsvector('english', username || ' ' || email))
    SQL
  end

  def drop
    execute <<-SQL
      DROP INDEX
        users_fulltext
    SQL
  end
end
