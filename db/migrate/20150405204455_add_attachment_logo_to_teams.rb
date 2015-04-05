class AddAttachmentLogoToTeams < ActiveRecord::Migration
  def self.up
    change_table :teams do |t|
      t.attachment :logo
      t.string :logo_fingerprint
    end
  end

  def self.down
    remove_attachment :teams, :logo
    remove_column :teams, :logo_fingerprint
  end
end
