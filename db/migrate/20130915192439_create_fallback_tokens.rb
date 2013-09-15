class CreateFallbackTokens < ActiveRecord::Migration
  def change
    create_table :fallback_tokens do |t|
      t.belongs_to :user, index: true
      t.string :key
      t.string :secret_digest

      t.timestamps
    end
  end
end
