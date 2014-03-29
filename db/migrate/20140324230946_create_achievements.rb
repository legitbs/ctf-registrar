class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.string :name, unique: true, index: true
      t.string :condition
      t.string :description
      t.string :image
      t.belongs_to :trophy, index: true

      t.timestamps

      t.foreign_key :trophies
    end
  end
end
