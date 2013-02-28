class IndexUserFields < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.index :username
      t.index :email
    end
  end
end
