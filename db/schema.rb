# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_17_114111) do

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link"
  end

  create_table "games_refreshes", force: :cascade do |t|
    t.integer "game_id"
    t.integer "refresh_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_games_refreshes_on_game_id"
    t.index ["refresh_id", "game_id"], name: "index_games_refreshes_on_refresh_id_and_game_id", unique: true
    t.index ["refresh_id"], name: "index_games_refreshes_on_refresh_id"
  end

  create_table "prices", force: :cascade do |t|
    t.integer "game_id"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_prices_on_game_id"
  end

  create_table "refreshes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "games_refreshes", "games"
  add_foreign_key "games_refreshes", "refreshes"
  add_foreign_key "prices", "games"
end
