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

ActiveRecord::Schema.define(version: 20141208234813) do

  create_table "blog_posts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.integer  "user_id"
    t.integer  "torrent_id"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "metadata"
  end

  create_table "packages", force: true do |t|
    t.integer  "torrent_id"
    t.integer  "user_id"
    t.string   "file_token"
    t.boolean  "is_available", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "torrents", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "uploader_id"
    t.string   "file_name"
    t.string   "transmission_hash"
    t.boolean  "soft_delete",       default: false
    t.integer  "download_count"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.boolean  "is_moderator",           default: false
    t.boolean  "is_admin",               default: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
