class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.belongs_to :achievement, index: true
      t.belongs_to :team, index: true
      t.string :comment

      t.timestamps
    end
  end
end
