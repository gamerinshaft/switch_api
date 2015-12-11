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

ActiveRecord::Schema.define(version: 20151211143436) do

  create_table "auth_tokens", force: :cascade do |t|
    t.string   "token"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "auth_tokens", ["user_id"], name: "index_auth_tokens_on_user_id"

  create_table "infrared_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "infrared_groups", ["user_id"], name: "index_infrared_groups_on_user_id"

  create_table "infrared_relationals", force: :cascade do |t|
    t.integer  "infrared_id"
    t.integer  "infrared_group_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "infrared_relationals", ["infrared_group_id"], name: "index_infrared_relationals_on_infrared_group_id"
  add_index "infrared_relationals", ["infrared_id"], name: "index_infrared_relationals_on_infrared_id"

  create_table "infrareds", force: :cascade do |t|
    t.string   "name"
    t.string   "data"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "count",      default: 0
  end

  add_index "infrareds", ["user_id"], name: "index_infrareds_on_user_id"

  create_table "logs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "infrared_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.integer  "status"
  end

  add_index "logs", ["infrared_id"], name: "index_logs_on_infrared_id"
  add_index "logs", ["user_id"], name: "index_logs_on_user_id"

  create_table "schedules", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "cron"
    t.string   "job_name"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "schedules", ["user_id"], name: "index_schedules_on_user_id"

  create_table "user_infos", force: :cascade do |t|
    t.string   "screen_name"
    t.string   "hashed_password"
    t.string   "email"
    t.string   "email_for_index"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "user_infos", ["user_id"], name: "index_user_infos_on_user_id"

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
