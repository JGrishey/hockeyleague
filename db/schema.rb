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

ActiveRecord::Schema.define(version: 20171024005557) do

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

  create_table "movements", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "trade_id"
    t.bigint "team_player_id"
    t.integer "origin_id"
    t.integer "destination_id"
    t.index ["destination_id"], name: "index_movements_on_destination_id"
    t.index ["origin_id"], name: "index_movements_on_origin_id"
    t.index ["team_player_id"], name: "index_movements_on_team_player_id"
    t.index ["trade_id"], name: "index_movements_on_trade_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "body"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "src"
    t.index ["user_id"], name: "index_notifications_on_user_id"
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
    t.boolean "current", default: false
    t.index ["league_id"], name: "index_seasons_on_league_id"
  end

  create_table "signups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "season_id"
    t.text "willing", default: [], array: true
    t.string "preferred", default: ""
    t.string "mia", default: ""
    t.boolean "part_time", default: false
    t.boolean "veteran", default: true
    t.index ["season_id"], name: "index_signups_on_season_id"
    t.index ["user_id"], name: "index_signups_on_user_id"
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
    t.integer "goals", default: 0
    t.integer "assists", default: 0
    t.integer "pim", default: 0
    t.integer "ppg", default: 0
    t.integer "shg", default: 0
    t.bigint "season_id"
    t.index ["game_id"], name: "index_stat_lines_on_game_id"
    t.index ["game_player_id"], name: "index_stat_lines_on_game_player_id"
    t.index ["season_id"], name: "index_stat_lines_on_season_id"
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
    t.integer "salary", default: 0
    t.index ["team_id"], name: "index_team_players_on_team_id"
    t.index ["user_id"], name: "index_team_players_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "season_id"
    t.integer "captain_id"
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.integer "logo_file_size"
    t.datetime "logo_updated_at"
    t.boolean "visibility", default: true
    t.integer "salary_cap", default: 0
    t.index ["captain_id"], name: "index_teams_on_captain_id"
    t.index ["season_id"], name: "index_teams_on_season_id"
  end

  create_table "trades", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "season_id"
    t.boolean "pending", default: true
    t.boolean "approved", default: false
    t.index ["season_id"], name: "index_trades_on_season_id"
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
    t.bigint "team_id"
    t.date "born"
    t.string "height"
    t.string "weight"
    t.string "birthplace"
    t.string "banner"
    t.boolean "admin", default: false
    t.boolean "stat_admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["team_id"], name: "index_users_on_team_id"
    t.index ["user_name"], name: "index_users_on_user_name", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.string "votable_type"
    t.bigint "votable_id"
    t.string "voter_type"
    t.bigint "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_votes_on_voter_type_and_voter_id"
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "game_players", "teams"
  add_foreign_key "games", "seasons"
  add_foreign_key "goals", "games"
  add_foreign_key "goals", "teams"
  add_foreign_key "messages", "chat_boxes"
  add_foreign_key "messages", "users"
  add_foreign_key "movements", "team_players"
  add_foreign_key "movements", "trades"
  add_foreign_key "notifications", "users"
  add_foreign_key "penalties", "games"
  add_foreign_key "penalties", "teams"
  add_foreign_key "penalties", "users"
  add_foreign_key "posts", "subforums"
  add_foreign_key "posts", "users"
  add_foreign_key "seasons", "leagues"
  add_foreign_key "signups", "seasons"
  add_foreign_key "signups", "users"
  add_foreign_key "stat_lines", "game_players"
  add_foreign_key "stat_lines", "games"
  add_foreign_key "stat_lines", "seasons"
  add_foreign_key "stat_lines", "teams"
  add_foreign_key "stat_lines", "users"
  add_foreign_key "team_players", "teams"
  add_foreign_key "team_players", "users"
  add_foreign_key "teams", "seasons"
  add_foreign_key "trades", "seasons"
  add_foreign_key "users", "teams"

  create_view "season_team_stats",  sql_definition: <<-SQL
      SELECT games.id,
      games.home_id,
      games.away_id,
      games.date,
      games.created_at,
      games.updated_at,
      games.season_id,
      games.home_toa_minutes,
      games.away_toa_minutes,
      games.home_toa_seconds,
      games.away_toa_seconds,
      games.home_ppg,
      games.away_ppg,
      games.home_ppo,
      games.away_ppo,
      games.final,
      games.overtime
     FROM games;
  SQL

  create_view "season_player_stats",  sql_definition: <<-SQL
      SELECT stat_lines.user_id,
      games.season_id,
      sum(
          CASE
              WHEN ((stat_lines."position")::text <> 'G'::text) THEN stat_lines.goals
              ELSE NULL::integer
          END) AS goals,
      sum(
          CASE
              WHEN ((stat_lines."position")::text <> 'G'::text) THEN stat_lines.assists
              ELSE NULL::integer
          END) AS assists,
      (sum(
          CASE
              WHEN ((stat_lines."position")::text <> 'G'::text) THEN stat_lines.goals
              ELSE NULL::integer
          END) + sum(
          CASE
              WHEN ((stat_lines."position")::text <> 'G'::text) THEN stat_lines.assists
              ELSE NULL::integer
          END)) AS points,
      count(
          CASE
              WHEN ((stat_lines."position")::text <> 'G'::text) THEN 1
              ELSE NULL::integer
          END) AS games_played,
      COALESCE((((sum(
          CASE
              WHEN ((stat_lines."position")::text <> 'G'::text) THEN stat_lines.goals
              ELSE NULL::integer
          END) + sum(
          CASE
              WHEN ((stat_lines."position")::text <> 'G'::text) THEN stat_lines.assists
              ELSE NULL::integer
          END)))::double precision / (NULLIF(count(*), 0))::double precision), (0)::double precision) AS p_per,
      count(
          CASE
              WHEN ((stat_lines."position")::text = 'G'::text) THEN 1
              ELSE NULL::integer
          END) AS goalie_games,
      sum(
          CASE
              WHEN ((stat_lines."position")::text <> 'G'::text) THEN stat_lines.plus_minus
              ELSE NULL::integer
          END) AS plus_minus,
      sum(
          CASE
              WHEN ((stat_lines."position")::text <> 'G'::text) THEN stat_lines.pim
              ELSE NULL::integer
          END) AS pim,
      sum(stat_lines.ppg) AS ppg,
      sum(stat_lines.shg) AS shg,
      sum(stat_lines.shots) AS shots,
      sum(stat_lines.hits) AS hits,
      COALESCE(((sum(stat_lines.goals))::double precision / (NULLIF(sum(stat_lines.shots), 0))::double precision), (0)::double precision) AS sh_per,
      sum(stat_lines.fow) AS fow,
      sum(stat_lines.fot) AS fot,
      COALESCE(((sum(stat_lines.fow))::double precision / (NULLIF(sum(stat_lines.fot), 0))::double precision), (0)::double precision) AS fo_per,
      sum(stat_lines.goals_against) AS ga,
      sum(stat_lines.shots_against) AS sa,
      COALESCE((((sum(stat_lines.shots_against) - sum(stat_lines.goals_against)))::double precision / (NULLIF(sum(stat_lines.shots_against), 0))::double precision), (0)::double precision) AS sv_per,
      COALESCE(((sum(stat_lines.goals_against))::double precision / (NULLIF(count(
          CASE
              WHEN ((stat_lines."position")::text = 'G'::text) THEN 1
              ELSE NULL::integer
          END), 0))::double precision), (0)::double precision) AS gaa,
      count(
          CASE
              WHEN ((stat_lines.goals_against = 0) AND ((stat_lines."position")::text = 'G'::text)) THEN 1
              ELSE NULL::integer
          END) AS so,
      sum(
          CASE
              WHEN ((stat_lines."position")::text = 'G'::text) THEN stat_lines.assists
              ELSE 0
          END) AS g_assists,
      sum(
          CASE
              WHEN ((stat_lines."position")::text = 'G'::text) THEN stat_lines.goals
              ELSE 0
          END) AS g_goals
     FROM (stat_lines
       JOIN games ON ((stat_lines.game_id = games.id)))
    WHERE (games.final = true)
    GROUP BY stat_lines.user_id, games.season_id
    ORDER BY stat_lines.user_id, games.season_id;
  SQL

end
