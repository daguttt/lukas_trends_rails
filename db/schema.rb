# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_01_20_232855) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "question", limit: 255
    t.text "reply"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "symbol"
    t.index ["name"], name: "index_currencies_on_name", unique: true
  end

  create_table "histories", force: :cascade do |t|
    t.date "date"
    t.decimal "lukas_value", precision: 10, scale: 2
    t.bigint "currency_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_histories_on_currency_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name", limit: 80
    t.string "password", limit: 70
    t.string "email", limit: 100
    t.integer "subscription_type"
    t.integer "role"
    t.json "preferences"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "chats", "users"
  add_foreign_key "histories", "currencies"
end
