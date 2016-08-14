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

ActiveRecord::Schema.define(version: 20160814074318) do

  create_table "cargos", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "volume",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "port_opening_locations", force: :cascade do |t|
    t.integer  "port_id",       null: false
    t.date     "first_date",    null: false
    t.date     "last_date",     null: false
    t.integer  "portable_id"
    t.string   "portable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "port_opening_locations", ["portable_type", "portable_id"], name: "index_port_opening_locations_on_portable_type_and_portable_id"

  create_table "ports", force: :cascade do |t|
    t.string   "title",      null: false
    t.float    "lat",        null: false
    t.float    "lng",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ships", force: :cascade do |t|
    t.string   "name",          null: false
    t.integer  "hold_capacity", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
