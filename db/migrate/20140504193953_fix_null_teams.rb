class FixNullTeams < ActiveRecord::Migration
  def up
    Team.transaction do
      null_teams = Team.where(user_id: nil)
      null_teams.each do |t|
        u = User.new
        u.username = "#{t.name} holder #{SecureRandom.urlsafe_base64}"
        u.email = "vito+team#{t.id}@legitbs.net"
        u.team = t
        u.password = u.password_confirmation = SecureRandom.urlsafe_base64
        u.save!
        t.user_id = u.id
        t.save!
      end
    end

    change_column_null :teams, :user_id, false
  end
end
