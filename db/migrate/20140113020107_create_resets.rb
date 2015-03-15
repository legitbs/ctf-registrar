class CreateResets < ActiveRecord::Migration
  def change
    create_table :resets do |t|
      t.belongs_to :user, index: true, null: false
      t.string :key, index: { unique: true }, null: false
      t.string :digest, null: false

      t.datetime :consumed_at
      t.datetime :disavowed_at

      t.timestamps

      t.index %i{ key disavowed_at consumed_at }
    end
  end
end
