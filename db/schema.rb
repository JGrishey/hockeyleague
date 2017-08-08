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

ActiveRecord::Schema.define(version: 20170807172408) do

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

  create_table "game_players", force: :cascade do |t|
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "game_id"
    t.bigint "user_id"
    t.bigint "team_id"
    t.index ["game_id"], name: "index_game_players_on_game_id"
    t.index ["team_id"], name: "index_game_players_on_team_id"
    t.index ["user_id"], name: "index_game_players_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "home_id"
    t.integer "away_id"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "season_id"
    t.integer "home_toa_minutes", default: 0
    t.integer "away_toa_minutes", default: 0
    t.integer "home_toa_seconds", default: 0
    t.integer "away_toa_seconds", default: 0
    t.integer "home_ppg", default: 0
    t.integer "away_ppg", default: 0
    t.integer "home_ppo", default: 0
    t.integer "away_ppo", default: 0
    t.boolean "final", default: false
    t.boolean "overtime", default: false
    t.index ["season_id"], name: "index_games_on_season_id"
  end

  create_table "goals", force: :cascade do |t|
    t.string "time_scored"
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
    t.string "position", default: ""
    t.integer "plus_minus", default: 0
    t.integer "shots", default: 0
    t.integer "fow", default: 0
    t.integer "fot", default: 0
    t.integer "hits", default: 0
    t.integer "shots_against", default: 0
    t.integer "goals_against", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "game_id"
    t.bigint "user_id"
    t.bigint "team_id"
    t.bigint "game_player_id"
    t.index ["game_id"], name: "index_stat_lines_on_game_id"
    t.index ["game_player_id"], name: "index_stat_lines_on_game_player_id"
    t.index ["team_id"], name: "index_stat_lines_on_team_id"
    t.index ["user_id"], name: "index_stat_lines_on_user_id"
  end

  create_table "subforums", force: :cascade do |t|
    t.text "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_players", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "team_id"
    t.index ["team_id"], name: "index_team_players_on_team_id"
    t.index ["user_id"], name: "index_team_players_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "season_id"
    t.integer "captain_id"
    t.index ["captain_id"], name: "index_teams_on_captain_id"
    t.index ["season_id"], name: "index_teams_on_season_id"
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
  add_foreign_key "game_players", "teams"
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
  add_foreign_key "stat_lines", "game_players"
  add_foreign_key "stat_lines", "games"
  add_foreign_key "stat_lines", "teams"
  add_foreign_key "stat_lines", "users"
  add_foreign_key "team_players", "teams"
  add_foreign_key "team_players", "users"
  add_foreign_key "teams", "seasons"
  add_foreign_key "users", "teams"
end
