class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.belongs_to :achievement, index: true
      t.belongs_to :team, index: true
      t.belongs_to :user, index: true
      t.string :comment

      t.timestamps

      t.index %i{ team_id achievement_id }
      t.foreign_key :teams
      t.foreign_key :users
      t.foreign_key :achievements
    end
  end
end
