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

ActiveRecord::Schema.define(version: 20160619102751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "connection_speciality_courses", force: :cascade do |t|
    t.integer  "id_speciality"
    t.integer  "id_course"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "weight"
  end

  create_table "connection_university_courses", force: :cascade do |t|
    t.integer  "id_course"
    t.integer  "id_university"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "connection_user_courses", force: :cascade do |t|
    t.integer  "id_user"
    t.integer  "id_course"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "edu_programs", force: :cascade do |t|
    t.string   "area",       limit: 255
    t.string   "course",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "specialities", force: :cascade do |t|
    t.integer  "id_speciality"
    t.string   "speciality"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "universities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "contact",    limit: 255
    t.string   "address",    limit: 255
    t.integer  "students"
    t.string   "price",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "email",             limit: 255
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "password_digest",   limit: 255
    t.string   "remember_digest",   limit: 255
    t.boolean  "admin"
    t.string   "activation_digest", limit: 255
    t.boolean  "activated",                     default: false
    t.datetime "activated_at"
    t.string   "reset_digest",      limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "widgets", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "stock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
