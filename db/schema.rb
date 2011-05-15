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

ActiveRecord::Schema.define(:version => 20110515142002) do

  create_table "arenas", :force => true do |t|
    t.float    "latitude",                  :default => 0.0
    t.float    "longitude",                 :default => 0.0
    t.string   "name",        :limit => 30
    t.text     "description"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", :force => true do |t|
    t.string   "name",        :limit => 30
    t.text     "description"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rounds", :force => true do |t|
    t.integer  "arena_id"
    t.string   "name",        :limit => 30
    t.text     "description"
    t.datetime "deadline"
    t.datetime "date"
    t.boolean  "confirmed",                 :default => false
    t.integer  "max_people",                :default => 1
    t.integer  "min_people",                :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
