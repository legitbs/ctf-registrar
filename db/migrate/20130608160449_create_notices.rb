class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :body
      t.belongs_to :team

      t.timestamps
    end
    add_index :notices, :team_id
  end
end
