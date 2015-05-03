class UniqueIndexesForUsersTeams < ActiveRecord::Migration
  def up
    remove_index :teams, :name
    add_index :teams, :name, unique: true
    remove_index :teams, :user_id
    add_index :teams, :user_id, unique: true

    remove_index :users, :username
    add_index :users, :username, unique: true
    remove_index :users, :email
    add_index :users, :email, unique: true
  end
end
