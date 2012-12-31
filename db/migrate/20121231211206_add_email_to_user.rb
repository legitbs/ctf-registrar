class AddEmailToUser < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :email_confirmation, :string
    add_column :users, :email_confirmed_at, :datetime
  end
end
