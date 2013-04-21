class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.belongs_to :team
      t.belongs_to :challenge

      t.timestamps
    end
    add_index :solutions, :team_id
    add_index :solutions, :challenge_id
  end
end
