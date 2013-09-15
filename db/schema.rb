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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130915194016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "challenges", force: true do |t|
    t.string   "name"
    t.string   "clue"
    t.string   "answer_digest"
    t.integer  "category_id"
    t.integer  "points"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "unlocked_at"
    t.datetime "solved_at"
  end

  add_index "challenges", ["category_id"], name: "index_challenges_on_category_id", using: :btree
  add_index "challenges", ["solved_at"], name: "challenges_solved_at_idx", using: :btree
  add_index "challenges", ["unlocked_at", "points"], name: "challenges_unlocked_at_points_idx", using: :btree
  add_index "challenges", ["unlocked_at"], name: "challenges_unlocked_at_idx", using: :btree

  create_table "fallback_tokens", force: true do |t|
    t.integer  "user_id"
    t.string   "key"
    t.string   "secret_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fallback_tokens", ["user_id"], name: "index_fallback_tokens_on_user_id", using: :btree

  create_table "notices", force: true do |t|
    t.string   "body"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notices", ["created_at"], name: "index_notices_on_created_at", using: :btree
  add_index "notices", ["team_id", "created_at"], name: "index_notices_on_team_id_and_created_at", using: :btree
  add_index "notices", ["team_id"], name: "index_notices_on_team_id", using: :btree

  create_table "solutions", force: true do |t|
    t.integer  "team_id"
    t.integer  "challenge_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "solutions", ["challenge_id"], name: "index_solutions_on_challenge_id", using: :btree
  add_index "solutions", ["team_id", "challenge_id"], name: "index_solutions_on_team_id_and_challenge_id", using: :btree
  add_index "solutions", ["team_id"], name: "index_solutions_on_team_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "hot"
    t.boolean  "prequalified"
    t.boolean  "fun"
  end

  add_index "teams", ["name"], name: "index_teams_on_name", using: :btree
  add_index "teams", ["user_id"], name: "index_teams_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.integer  "team_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "email"
    t.string   "email_confirmation"
    t.datetime "email_confirmed_at"
    t.boolean  "visa"
    t.string   "auth_secret"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["team_id"], name: "index_users_on_team_id", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

  add_foreign_key "challenges", "categories", :name => "challenges_category_id_fk"

  add_foreign_key "solutions", "challenges", :name => "solutions_challenge_id_fk"
  add_foreign_key "solutions", "teams", :name => "solutions_team_id_fk"

  add_foreign_key "teams", "users", :name => "teams_user_id_fk"

  add_foreign_key "users", "teams", :name => "users_team_id_fk"

end
