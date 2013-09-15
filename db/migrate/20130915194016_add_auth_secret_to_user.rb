class AddAuthSecretToUser < ActiveRecord::Migration
  def change
    add_column :users, :auth_secret, :string
  end
end
