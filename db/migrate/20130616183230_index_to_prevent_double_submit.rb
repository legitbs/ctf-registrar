class IndexToPreventDoubleSubmit < ActiveRecord::Migration
  def change
    change_table :solutions do |t|
      t.index %i{team_id challenge_id}
    end
  end
end
