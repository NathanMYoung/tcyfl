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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130323191113) do

  create_table "games", :force => true do |t|
    t.date     "gamedate"
    t.time     "gametime"
    t.integer  "hometeamId"
    t.integer  "visitorteamId"
    t.integer  "playingfieldId"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "gameschedules", :force => true do |t|
    t.integer  "game1"
    t.integer  "game2"
    t.integer  "game3"
    t.integer  "game4"
    t.integer  "game5"
    t.integer  "game6"
    t.integer  "game7"
    t.integer  "game8"
    t.integer  "game9"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "playingfields", :force => true do |t|
    t.string   "fieldname"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "community"
    t.string   "weight"
    t.string   "level"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "namecolor"
    t.integer  "firstfield"
    t.integer  "secondfield"
    t.integer  "scheduleid"
  end

  create_table "weights", :force => true do |t|
    t.string   "weightClass"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
