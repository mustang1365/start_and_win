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

ActiveRecord::Schema.define(:version => 20120309203933) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "provider",   :null => false
    t.string   "uid",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "competition_to_questions", :force => true do |t|
    t.integer  "question_id"
    t.integer  "competition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "difficulty_level_id"
    t.decimal  "competition_points",   :precision => 8, :scale => 2, :default => 0.0
    t.float    "rating",                                             :default => 0.0
  end

  add_index "competitions", ["difficulty_level_id"], :name => "difficulty_level_index"

  create_table "difficulty_level_settings", :force => true do |t|
    t.integer  "iq_level"
    t.integer  "difficulty_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "competition_max_points",     :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "question_max_points",        :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "competition_max_win_points", :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "question_max_win_points",    :precision => 8, :scale => 2, :default => 0.0
  end

  create_table "difficulty_levels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "education_levels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experience_settings", :force => true do |t|
    t.string   "competition_name"
    t.float    "iq_for_participant", :default => 0.0
    t.float    "iq_for_creator",     :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "financial_accounts", :force => true do |t|
    t.integer  "user_id"
    t.decimal  "points_amount",   :precision => 8, :scale => 0
    t.decimal  "reserved_points", :precision => 8, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "model_id"
    t.string   "model_type"
  end

  add_index "financial_accounts", ["model_id", "model_type"], :name => "financial_account_model_index"
  add_index "financial_accounts", ["user_id"], :name => "f_user_index"

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

  create_table "message_copies", :force => true do |t|
    t.integer  "recipient_id"
    t.integer  "sender_id"
    t.integer  "message_id"
    t.boolean  "deleted",      :default => false
    t.datetime "read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "message_copies", ["message_id"], :name => "copy_message_index"
  add_index "message_copies", ["recipient_id"], :name => "copy_recipient_index"
  add_index "message_copies", ["sender_id"], :name => "copy_sender_index"

  create_table "messages", :force => true do |t|
    t.text     "body"
    t.string   "subject"
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

  create_table "play_conditions", :force => true do |t|
    t.integer  "model_id"
    t.string   "model_type"
    t.decimal  "participation_points", :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "points_to_play",       :precision => 8, :scale => 2, :default => 0.0
    t.integer  "difficulty_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "win_points",           :precision => 8, :scale => 2, :default => 0.0
    t.integer  "time_limit",                                         :default => 10
  end

  add_index "play_conditions", ["difficulty_level_id"], :name => "play_difficulty_level_index"
  add_index "play_conditions", ["model_id", "model_type"], :name => "play_model_index"

  create_table "play_results", :force => true do |t|
    t.integer  "user_id"
    t.string   "competition_type"
    t.integer  "competition_id"
    t.string   "answers"
    t.boolean  "won",              :default => false
    t.boolean  "payed",            :default => false
    t.integer  "rating_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "play_results", ["competition_type", "competition_id"], :name => "result_competition_index"
  add_index "play_results", ["rating_id"], :name => "result_rating_index"
  add_index "play_results", ["user_id"], :name => "result_user_index"

  create_table "private_files", :force => true do |t|
    t.text     "file_content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "photo_id"
    t.integer  "user_id"
    t.text     "short_description"
    t.integer  "education_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["education_level_id"], :name => "education_level_index"
  add_index "profiles", ["photo_id"], :name => "photo_index"
  add_index "profiles", ["user_id"], :name => "users_index"

  create_table "questions", :force => true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",     :default => "Активный"
    t.integer  "user_id"
    t.float    "rating",     :default => 0.0
  end

  create_table "rating_rates", :force => true do |t|
    t.float    "begin_rating",    :default => 0.0
    t.float    "end_rating",      :default => 0.0
    t.float    "rate_of_payment", :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", :force => true do |t|
    t.float    "total_score",      :default => 0.0
    t.integer  "general_score",    :default => 5
    t.integer  "difficulty_score", :default => 5
    t.integer  "time_score",       :default => 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_categories", :force => true do |t|
    t.string   "title"
    t.integer  "main_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.decimal  "amount",       :precision => 8, :scale => 2, :default => 0.0
    t.string   "point_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "model_id"
    t.string   "model_type"
  end

  add_index "transactions", ["model_id", "model_type"], :name => "transaction_model_index"
  add_index "transactions", ["recipient_id"], :name => "transactions_recipient_index"
  add_index "transactions", ["sender_id"], :name => "transactions_sender_index"

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
    t.integer  "failed_logins_count",                                           :default => 0
    t.datetime "lock_expires_at"
    t.boolean  "admin"
    t.decimal  "iq_level",                        :precision => 8, :scale => 2, :default => 0.0
    t.string   "first_name",                                                    :default => "",  :null => false
    t.string   "last_name",                                                     :default => "",  :null => false
    t.string   "gender",                                                        :default => "",  :null => false
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
