class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.belongs_to :team, index: true, foreign_key: true
      t.belongs_to :challenge, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :observations, %i{team_id challenge_id}, unique: true
  end
end
