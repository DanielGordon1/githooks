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

ActiveRecord::Schema.define(version: 2020_05_25_123034) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commits", force: :cascade do |t|
    t.text "message"
    t.string "sha"
    t.datetime "committed_at"
    t.jsonb "ticket_identifiers", default: {}
    t.string "repository_name"
    t.integer "status"
    t.bigint "user_id", null: false
    t.bigint "release_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["release_id"], name: "index_commits_on_release_id"
    t.index ["user_id"], name: "index_commits_on_user_id"
  end

  create_table "releases", force: :cascade do |t|
    t.string "tag_name"
    t.datetime "released_at"
    t.integer "external_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_releases_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "external_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "commits", "releases"
  add_foreign_key "commits", "users"
  add_foreign_key "releases", "users"
end
