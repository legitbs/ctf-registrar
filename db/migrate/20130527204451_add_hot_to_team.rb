class AddHotToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :hot, :boolean
  end
end
