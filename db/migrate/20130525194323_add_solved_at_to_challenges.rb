class AddSolvedAtToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :solved_at, :datetime
  end
end
