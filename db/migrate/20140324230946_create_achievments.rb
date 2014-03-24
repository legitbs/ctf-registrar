class CreateAchievments < ActiveRecord::Migration
  def change
    create_table :achievments do |t|
      t.string :name
      t.string :condition
      t.string :description
      t.string :image
      t.belongs_to :trophy, index: true

      t.timestamps
    end
  end
end
