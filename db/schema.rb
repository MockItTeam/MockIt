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

ActiveRecord::Schema.define(version: 20160119115311) do

  create_table "invitations", force: :cascade do |t|
    t.integer  "from_user_id"
    t.integer  "to_user_id"
    t.integer  "project_id"
    t.integer  "status",       default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "invitations", ["from_user_id"], name: "index_invitations_on_from_user_id"
  add_index "invitations", ["status"], name: "index_invitations_on_status"
  add_index "invitations", ["to_user_id"], name: "index_invitations_on_to_user_id"

  create_table "mockups", force: :cascade do |t|
    t.string   "description"
    t.integer  "raw_image_id"
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "status",       default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "mockups", ["status"], name: "index_mockups_on_status"

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "projects", ["status"], name: "index_projects_on_status"

  create_table "projects_users", id: false, force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  add_index "projects_users", ["project_id"], name: "index_projects_users_on_project_id"
  add_index "projects_users", ["user_id"], name: "index_projects_users_on_user_id"

  create_table "raw_images", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "raw_images", ["status"], name: "index_raw_images_on_status"

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "pin"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "users", ["status"], name: "index_users_on_status"
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
