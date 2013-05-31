# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130527204451) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "order"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "challenges", :force => true do |t|
    t.string   "name"
    t.string   "clue"
    t.string   "answer_digest"
    t.integer  "category_id"
    t.integer  "points"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.datetime "unlocked_at"
    t.datetime "solved_at"
  end

  add_index "challenges", ["category_id"], :name => "index_challenges_on_category_id"

  create_table "solutions", :force => true do |t|
    t.integer  "team_id"
    t.integer  "challenge_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "solutions", ["challenge_id"], :name => "index_solutions_on_challenge_id"
  add_index "solutions", ["team_id"], :name => "index_solutions_on_team_id"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.boolean  "hot"
  end

  add_index "teams", ["name"], :name => "index_teams_on_name"
  add_index "teams", ["user_id"], :name => "index_teams_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.integer  "team_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "email"
    t.string   "email_confirmation"
    t.datetime "email_confirmed_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["team_id"], :name => "index_users_on_team_id"
  add_index "users", ["username"], :name => "index_users_on_username"

  add_foreign_key "challenges", "categories", :name => "challenges_category_id_fk"

  add_foreign_key "solutions", "challenges", :name => "solutions_challenge_id_fk"
  add_foreign_key "solutions", "teams", :name => "solutions_team_id_fk"

  add_foreign_key "teams", "users", :name => "teams_user_id_fk"

  add_foreign_key "users", "teams", :name => "users_team_id_fk"

end
