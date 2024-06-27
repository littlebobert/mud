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

ActiveRecord::Schema[7.1].define(version: 2024_06_27_184215) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.bigint "place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "only_speaks_japanese", default: false
    t.bigint "item_id"
    t.index ["item_id"], name: "index_characters_on_item_id"
    t.index ["place_id"], name: "index_characters_on_place_id"
  end

  create_table "chat_messages", force: :cascade do |t|
    t.string "content"
    t.bigint "place_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_chat_messages_on_place_id"
    t.index ["user_id"], name: "index_chat_messages_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "place_id"
    t.bigint "user_id"
    t.boolean "replenishes", default: false
    t.index ["place_id"], name: "index_items_on_place_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "links", force: :cascade do |t|
    t.bigint "from_id", null: false
    t.bigint "to_id", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_id"], name: "index_links_on_from_id"
    t.index ["to_id"], name: "index_links_on_to_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "user_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "from_user", default: false
    t.index ["character_id"], name: "index_messages_on_character_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "starting_zone", default: false
    t.string "area", default: "Meguro"
    t.boolean "outdoors", default: false
  end

  create_table "quest_logs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "quest_id", null: false
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quest_id"], name: "index_quest_logs_on_quest_id"
    t.index ["user_id"], name: "index_quest_logs_on_user_id"
  end

  create_table "quests", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.string "name"
    t.text "description"
    t.bigint "requirement_id", null: false
    t.bigint "reward_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "one_shot", default: false
    t.index ["character_id"], name: "index_quests_on_character_id"
    t.index ["requirement_id"], name: "index_quests_on_requirement_id"
    t.index ["reward_id"], name: "index_quests_on_reward_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.bigint "place_id"
    t.string "activity"
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["place_id"], name: "index_users_on_place_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weather_reports", force: :cascade do |t|
    t.string "area"
    t.float "temp"
    t.string "units"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "characters", "items"
  add_foreign_key "characters", "places"
  add_foreign_key "chat_messages", "places"
  add_foreign_key "chat_messages", "users"
  add_foreign_key "items", "places"
  add_foreign_key "items", "users"
  add_foreign_key "links", "places", column: "from_id"
  add_foreign_key "links", "places", column: "to_id"
  add_foreign_key "messages", "characters"
  add_foreign_key "messages", "users"
  add_foreign_key "quest_logs", "quests"
  add_foreign_key "quest_logs", "users"
  add_foreign_key "quests", "characters"
  add_foreign_key "quests", "items", column: "requirement_id"
  add_foreign_key "quests", "items", column: "reward_id"
  add_foreign_key "users", "places"
end
