class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :name
      t.string :clue
      t.string :answer_digest
      t.belongs_to :category
      t.integer :points

      t.timestamps
    end
    add_index :challenges, :category_id
  end
end
