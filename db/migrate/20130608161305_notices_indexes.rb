class NoticesIndexes < ActiveRecord::Migration
  def change
    change_table :notices do |t|
      t.index :created_at
      t.index %i{team_id created_at}
    end
  end
end
