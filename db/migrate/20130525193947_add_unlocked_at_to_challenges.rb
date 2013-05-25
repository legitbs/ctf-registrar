class AddUnlockedAtToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :unlocked_at, :datetime
  end
end
