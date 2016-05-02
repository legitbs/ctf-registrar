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

ActiveRecord::Schema.define(version: 20160430215440) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_stat_statements"

  create_table "achievements", force: :cascade do |t|
    t.string   "name"
    t.string   "condition"
    t.string   "description"
    t.string   "image"
    t.integer  "trophy_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "achievements", ["name"], name: "index_achievements_on_name", using: :btree
  add_index "achievements", ["trophy_id"], name: "index_achievements_on_trophy_id", using: :btree

  create_table "awards", force: :cascade do |t|
    t.integer  "achievement_id"
    t.integer  "team_id"
    t.integer  "user_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "awards", ["achievement_id"], name: "index_awards_on_achievement_id", using: :btree
  add_index "awards", ["team_id", "achievement_id"], name: "index_awards_on_team_id_and_achievement_id", unique: true, using: :btree
  add_index "awards", ["team_id"], name: "index_awards_on_team_id", using: :btree
  add_index "awards", ["user_id"], name: "index_awards_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "challenges", force: :cascade do |t|
    t.string   "name"
    t.string   "clue"
    t.string   "answer_digest"
    t.integer  "category_id"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "unlocked_at"
    t.datetime "solved_at"
  end

  add_index "challenges", ["category_id"], name: "index_challenges_on_category_id", using: :btree

  create_table "fallback_tokens", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "key"
    t.string   "secret_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fallback_tokens", ["user_id"], name: "index_fallback_tokens_on_user_id", using: :btree

  create_table "notices", force: :cascade do |t|
    t.string   "body"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter"
  end

  add_index "notices", ["created_at"], name: "index_notices_on_created_at", using: :btree
  add_index "notices", ["team_id", "created_at"], name: "index_notices_on_team_id_and_created_at", using: :btree
  add_index "notices", ["team_id"], name: "index_notices_on_team_id", using: :btree

  create_table "resets", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.string   "key",          null: false
    t.string   "digest",       null: false
    t.datetime "consumed_at"
    t.datetime "disavowed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resets", ["key", "disavowed_at", "consumed_at"], name: "index_resets_on_key_and_disavowed_at_and_consumed_at", using: :btree
  add_index "resets", ["key"], name: "index_resets_on_key", unique: true, using: :btree
  add_index "resets", ["user_id"], name: "index_resets_on_user_id", using: :btree

  create_table "solutions", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "solutions", ["challenge_id"], name: "index_solutions_on_challenge_id", using: :btree
  add_index "solutions", ["team_id", "challenge_id"], name: "index_solutions_on_team_id_and_challenge_id", unique: true, using: :btree
  add_index "solutions", ["team_id"], name: "index_solutions_on_team_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.integer  "user_id",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hot"
    t.boolean  "prequalified"
    t.boolean  "fun"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "logo_fingerprint"
    t.string   "display"
  end

  add_index "teams", ["name"], name: "index_teams_on_name", unique: true, using: :btree
  add_index "teams", ["user_id"], name: "index_teams_on_user_id", unique: true, using: :btree

  create_table "trophies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "email_confirmation"
    t.datetime "email_confirmed_at"
    t.boolean  "visa"
    t.string   "auth_secret"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["team_id"], name: "index_users_on_team_id", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "achievements", "trophies", name: "achievements_trophy_id_fk"
  add_foreign_key "awards", "achievements", name: "awards_achievement_id_fk"
  add_foreign_key "awards", "teams", name: "awards_team_id_fk"
  add_foreign_key "awards", "users", name: "awards_user_id_fk"
  add_foreign_key "challenges", "categories", name: "challenges_category_id_fk"
  add_foreign_key "solutions", "challenges", name: "solutions_challenge_id_fk"
  add_foreign_key "solutions", "teams", name: "solutions_team_id_fk"
  add_foreign_key "teams", "users", name: "teams_user_id_fk"
  add_foreign_key "users", "teams", name: "users_team_id_fk"
end
