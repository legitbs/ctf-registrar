class IndexTeamFulltext < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE INDEX 
        teams_fulltext 
      ON 
        teams 
      USING 
        gin(to_tsvector('english', name))
    SQL
  end

  def drop
    execute <<-SQL
      DROP INDEX
        teams_fulltext
    SQL
  end
end
