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

ActiveRecord::Schema.define(version: 20140827144412) do

  create_table "comments", force: true do |t|
    t.integer  "update_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["update_id", "user_id"], name: "index_comments_on_update_id_and_user_id"

  create_table "feedbacks", force: true do |t|
    t.text     "remark"
    t.string   "token"
    t.date     "month"
    t.integer  "user_id"
    t.integer  "rating_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedbacks", ["rating_id"], name: "index_feedbacks_on_rating_id"
  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id"

  create_table "mentees_mentors", id: false, force: true do |t|
    t.integer "mentee_id", null: false
    t.integer "mentor_id", null: false
  end

  add_index "mentees_mentors", ["mentor_id", "mentee_id"], name: "index_mentees_mentors_on_mentor_id_and_mentee_id"

  create_table "ratings", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "role_id", null: false
    t.integer "user_id", null: false
  end

  add_index "roles_users", ["user_id", "role_id"], name: "index_roles_users_on_user_id_and_role_id"

  create_table "tasks", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "details"
    t.date     "deadline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status",     default: true
  end

  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id"

  create_table "tasks_updates", id: false, force: true do |t|
    t.integer "task_id"
    t.integer "update_id"
  end

  create_table "updates", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "updates", ["user_id", "created_at"], name: "index_updates_on_user_id_and_created_at"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "emp_id"
    t.string   "phn_no"
    t.integer  "card_no"
    t.string   "location"
    t.string   "address"
    t.string   "technology"
    t.integer  "experience"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "associate"
    t.string   "first_login_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
