class AddTwitterToNotices < ActiveRecord::Migration
  def change
    add_column :notices, :twitter, :string
  end
end
