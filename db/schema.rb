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

ActiveRecord::Schema.define(:version => 20111225121125) do

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "competitions", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "image_id"
    t.boolean  "system",                                             :default => false
    t.integer  "user_id"
    t.decimal  "win_points",           :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "participation_points", :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.text     "image_content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "main_categories", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "model_to_main_categories", :force => true do |t|
    t.integer  "main_category_id"
    t.integer  "model_id"
    t.string   "model_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "model_to_main_categories", ["main_category_id"], :name => "main_category_index"
  add_index "model_to_main_categories", ["model_id", "model_type"], :name => "model_cat_index"

  create_table "model_to_main_category_to_sub_categories", :id => false, :force => true do |t|
    t.integer  "sub_category_id"
    t.integer  "model_to_main_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "model_to_main_category_to_sub_categories", ["model_to_main_category_id"], :name => "model_to_main_category_index"
  add_index "model_to_main_category_to_sub_categories", ["sub_category_id"], :name => "sub_category_index"

  create_table "news_points", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "image_id"
  end

  create_table "questions", :force => true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_categories", :force => true do |t|
    t.string   "title"
    t.integer  "main_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.integer  "failed_logins_count",             :default => 0
    t.datetime "lock_expires_at"
    t.boolean  "admin"
  end

  add_index "users", ["last_logout_at", "last_activity_at"], :name => "index_users_on_last_logout_at_and_last_activity_at"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

  create_table "variants", :force => true do |t|
    t.string   "text"
    t.integer  "question_id"
    t.boolean  "answer",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
