class FixAwardIndexToBeUnique < ActiveRecord::Migration
  def up
    synack = Achievement.where(name: 'syn-ack').first
    Team.transaction do 
      Team.all.find_each do |t|
        awards = t.awards.where(achievement_id: synack.id).order(created_at: :asc).offset(1)
        next if awards.empty?
        awards.each(&:destroy)
      end
    end
    remove_index :awards, column: %i{ team_id achievement_id }
    add_index :awards, %i{ team_id achievement_id }, unique: true
  end

  def down
    remove_index :awards, column: %i{ team_id achievement_id }
    add_index :awards, %i{ team_id achievement_id }, unique: false
  end
end
