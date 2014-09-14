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

ActiveRecord::Schema.define(version: 20140914182724) do

  create_table "devices", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.boolean  "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "wattage",    precision: 10, scale: 0
  end

  create_table "humidity_readings", force: true do |t|
    t.decimal  "humidity",   precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "power_consumptions", force: true do |t|
    t.integer  "device_id"
    t.decimal  "power_consumed", precision: 10, scale: 0
    t.decimal  "cost",           precision: 8,  scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "temperature_readings", force: true do |t|
    t.decimal  "temperature", precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "triggers", force: true do |t|
    t.string   "condition"
    t.string   "reading_type"
    t.decimal  "value",        precision: 10, scale: 0
    t.boolean  "state"
    t.integer  "device_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
