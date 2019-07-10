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

ActiveRecord::Schema.define(version: 2015_08_30_002734) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_participations", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["event_id"], name: "index_event_participations_on_event_id"
    t.index ["user_id"], name: "index_event_participations_on_user_id"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "url"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "email"
    t.text "introduction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "github_id"
    t.string "twitter_name"
    t.string "github_url"
    t.string "facebook_name"
    t.string "nickname"
    t.string "location"
    t.string "blog"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.date "birthday"
    t.string "qiita_name"
    t.datetime "profile_updated_at"
    t.boolean "new_user_notification_enabled", default: false, null: false
    t.datetime "first_active_at"
    t.index ["github_id"], name: "index_users_on_github_id", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
  end

end
