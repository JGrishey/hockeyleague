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

ActiveRecord::Schema.define(version: 20170801180514) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_boxes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "post_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "home_id"
    t.integer "away_id"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "season_id"
    t.index ["season_id"], name: "index_games_on_season_id"
  end

  create_table "goals", force: :cascade do |t|
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "scorer_id"
    t.integer "primary_id"
    t.integer "secondary_id"
    t.bigint "game_id"
    t.bigint "team_id"
    t.index ["game_id"], name: "index_goals_on_game_id"
    t.index ["primary_id"], name: "index_goals_on_primary_id"
    t.index ["scorer_id"], name: "index_goals_on_scorer_id"
    t.index ["secondary_id"], name: "index_goals_on_secondary_id"
    t.index ["team_id"], name: "index_goals_on_team_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.bigint "user_id"
    t.bigint "chat_box_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_box_id"], name: "index_messages_on_chat_box_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "penalties", force: :cascade do |t|
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "team_id"
    t.bigint "game_id"
    t.index ["game_id"], name: "index_penalties_on_game_id"
    t.index ["team_id"], name: "index_penalties_on_team_id"
    t.index ["user_id"], name: "index_penalties_on_user_id"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.bigint "subforum_id"
    t.index ["subforum_id"], name: "index_posts_on_subforum_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "league_id"
    t.index ["league_id"], name: "index_seasons_on_league_id"
  end

  create_table "stat_lines", force: :cascade do |t|
    t.string "position"
    t.integer "plus_minus"
    t.integer "shots"
    t.integer "fow"
    t.integer "fot"
    t.integer "hits"
    t.integer "shots_against"
    t.integer "goals_against"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "game_id"
    t.bigint "user_id"
    t.bigint "team_id"
    t.index ["game_id"], name: "index_stat_lines_on_game_id"
    t.index ["team_id"], name: "index_stat_lines_on_team_id"
    t.index ["user_id"], name: "index_stat_lines_on_user_id"
  end

  create_table "subforums", force: :cascade do |t|
    t.text "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "season_id"
    t.bigint "user_id"
    t.index ["season_id"], name: "index_teams_on_season_id"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "user_name", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "bio"
    t.bigint "team_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["team_id"], name: "index_users_on_team_id"
    t.index ["user_name"], name: "index_users_on_user_name", unique: true
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "games", "seasons"
  add_foreign_key "goals", "games"
  add_foreign_key "goals", "teams"
  add_foreign_key "messages", "chat_boxes"
  add_foreign_key "messages", "users"
  add_foreign_key "penalties", "games"
  add_foreign_key "penalties", "teams"
  add_foreign_key "penalties", "users"
  add_foreign_key "posts", "subforums"
  add_foreign_key "posts", "users"
  add_foreign_key "seasons", "leagues"
  add_foreign_key "stat_lines", "games"
  add_foreign_key "stat_lines", "teams"
  add_foreign_key "stat_lines", "users"
  add_foreign_key "teams", "seasons"
  add_foreign_key "teams", "users"
  add_foreign_key "users", "teams"
end
