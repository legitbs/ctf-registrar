class AddVisaAndFunToUsers < ActiveRecord::Migration
  def change
    add_column :users, :visa, :boolean
  end
end
