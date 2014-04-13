class IndexNoticeFulltext < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE INDEX 
        notices_fulltext 
      ON 
        notices 
      USING 
        gin(to_tsvector('english', body))
    SQL
  end

  def drop
    execute <<-SQL
      DROP INDEX
        notices_fulltext
    SQL
  end
end
