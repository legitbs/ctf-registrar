class AddForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key "challenges", "categories", :name => "challenges_category_id_fk"
    add_foreign_key "solutions", "challenges", :name => "solutions_challenge_id_fk"
    add_foreign_key "solutions", "teams", :name => "solutions_team_id_fk"
    add_foreign_key "teams", "users", :name => "teams_user_id_fk"
    add_foreign_key "users", "teams", :name => "users_team_id_fk"
  end
end
