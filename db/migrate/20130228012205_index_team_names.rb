class IndexTeamNames < ActiveRecord::Migration
  def change
    change_table :teams do |t|
      t.index :name
    end
  end
end
