class AddPrequalifiedAndFunToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :prequalified, :boolean
    add_column :teams, :fun, :boolean
  end
end
