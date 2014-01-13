class CreateResets < ActiveRecord::Migration
  def change
    create_table :resets do |t|
      t.belongs_to :user, index: true
      t.string :key
      t.string :digest

      t.timestamps
    end
  end
end
