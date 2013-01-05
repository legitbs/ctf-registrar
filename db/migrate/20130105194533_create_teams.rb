class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :tag
      t.string :password_digest
      t.belongs_to :user

      t.timestamps
    end
    add_index :teams, :user_id
  end
end
