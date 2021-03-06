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

ActiveRecord::Schema.define(version: 20160116204420) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "user_id",     null: false
    t.string   "access_code", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "courses", ["access_code"], name: "index_courses_on_access_code", using: :btree
  add_index "courses", ["user_id"], name: "index_courses_on_user_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "enrollments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id",   null: false
    t.string   "external_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "enrollments", ["course_id"], name: "index_enrollments_on_course_id", using: :btree
  add_index "enrollments", ["external_id"], name: "index_enrollments_on_external_id", using: :btree
  add_index "enrollments", ["user_id", "course_id"], name: "index_enrollments_on_user_id_and_course_id", using: :btree
  add_index "enrollments", ["user_id"], name: "index_enrollments_on_user_id", using: :btree

  create_table "polls", force: :cascade do |t|
    t.integer  "course_id",                     null: false
    t.text     "description",   default: "",    null: false
    t.integer  "choices_count",                 null: false
    t.boolean  "active",        default: false, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "answer"
  end

  add_index "polls", ["course_id"], name: "index_polls_on_course_id", using: :btree

  create_table "responses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "poll_id"
    t.integer  "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "responses", ["poll_id"], name: "index_responses_on_poll_id", using: :btree
  add_index "responses", ["user_id"], name: "index_responses_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "token",           null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["token"], name: "index_users_on_token", using: :btree

  add_foreign_key "courses", "users"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "users"
  add_foreign_key "polls", "courses"
  add_foreign_key "responses", "polls"
  add_foreign_key "responses", "users"
end
