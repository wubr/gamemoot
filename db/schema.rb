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

ActiveRecord::Schema.define(version: 20170902193904) do

  create_table "games", force: :cascade do |t|
    t.string "name", null: false
    t.integer "bgg_game_id"
    t.integer "min_players"
    t.integer "max_players"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bgg_game_id"], name: "index_games_on_bgg_game_id", unique: true
    t.index ["name"], name: "index_games_on_name", unique: true
  end

  create_table "games_tables", id: false, force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "table_id", null: false
    t.index ["game_id"], name: "index_games_tables_on_game_id"
    t.index ["table_id"], name: "index_games_tables_on_table_id"
  end

  create_table "tables", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "starts_at"
    t.integer "max_seats", default: 0
    t.text "comments"
    t.text "requirements"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
