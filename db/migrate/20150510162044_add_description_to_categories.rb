class AddDescriptionToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :description, :text
    add_index :categories, :name, unique: true
  end
end
