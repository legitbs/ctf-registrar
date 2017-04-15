class CreateUploads < ActiveRecord::Migration[5.0]
  def change
    create_table :uploads do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :challenge, foreign_key: true
      t.attachment :file

      t.timestamps
    end
  end
end
