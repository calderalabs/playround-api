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

ActiveRecord::Schema.define(:version => 20110807103349) do

  create_table "arenas", :force => true do |t|
    t.integer  "user_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.float    "latitude",                         :default => 0.0
    t.float    "longitude",                        :default => 0.0
    t.integer  "town_woeid",         :limit => 8
    t.string   "name",               :limit => 30
    t.text     "description"
    t.string   "website"
    t.boolean  "public",                           :default => false
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "round_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", :force => true do |t|
    t.integer  "user_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "name",               :limit => 30
    t.text     "description"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quicktours", :force => true do |t|
    t.integer  "user_id"
    t.integer  "current_guider", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rounds", :force => true do |t|
    t.integer  "user_id"
    t.integer  "arena_id"
    t.integer  "game_id"
    t.text     "description"
    t.datetime "date"
    t.integer  "people",      :default => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "round_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.integer  "town_woeid",          :limit => 8
    t.string   "email"
    t.string   "display_name"
    t.string   "real_name",           :limit => 30
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "encrypted_password",  :limit => 128
    t.string   "salt",                :limit => 128
    t.string   "confirmation_token",  :limit => 128
    t.string   "remember_token",      :limit => 128
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "show_email"
    t.string   "language"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
