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

ActiveRecord::Schema.define(version: 20190919175313) do

  create_table "employees", force: :cascade do |t|
    t.string "Lastname"
    t.string "Firstname"
    t.string "Cost_Center_Code"
    t.string "image"
    t.string "Badge_No"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "Employee_Status"
    t.string "badge_"
  end

  create_table "meals", force: :cascade do |t|
    t.string "title"
    t.string "collect_window"
    t.integer "qty"
    t.string "employee"
    t.time "collected"
    t.date "menu_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "normal_image"
    t.boolean "collected_flag"
    t.boolean "collect_flag"
    t.boolean "delivered_flag"
  end

  create_table "menus", force: :cascade do |t|
    t.date "menu_date"
    t.integer "qty"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "window"
    t.string "image"
    t.string "normal_image"
  end

  create_table "recipe_images", force: :cascade do |t|
    t.integer "recipe_id"
    t.string "title"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_loads", force: :cascade do |t|
    t.string "badge"
    t.string "ssn4"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
