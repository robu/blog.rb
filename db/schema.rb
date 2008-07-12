# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080712205335) do

  create_table "blogs", :force => true do |t|
    t.string   "path_name"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default_blog", :default => false
  end

  create_table "contents", :force => true do |t|
    t.text     "target"
    t.text     "source"
    t.string   "source_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.integer  "blog_id",      :limit => 11
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "content_id",   :limit => 11
  end

  create_table "posts_users", :id => false, :force => true do |t|
    t.integer "post_id", :limit => 11
    t.integer "user_id", :limit => 11
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "hashed_password"
    t.string   "password_salt"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users_blogs", :id => false, :force => true do |t|
    t.integer "user_id", :limit => 11
    t.integer "blog_id", :limit => 11
  end

end
