class RemoveTagFromTeams < ActiveRecord::Migration
  def up
    remove_column :teams, :tag
  end

  def down
    add_column :teams, :tag, :string
  end
end
