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

ActiveRecord::Schema.define(version: 20151010191359) do

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "banner_positions", force: true do |t|
    t.string   "description"
    t.string   "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banners", force: true do |t|
    t.integer  "banner_position_id"
    t.string   "url"
    t.integer  "ordering"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "new_window"
  end

  create_table "carts", force: true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carts", ["product_id"], name: "index_carts_on_product_id"
  add_index "carts", ["user_id"], name: "index_carts_on_user_id"

  create_table "images", force: true do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_types", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", force: true do |t|
    t.integer  "menu_type_id"
    t.integer  "page_id"
    t.integer  "menu_id"
    t.string   "title"
    t.string   "url"
    t.string   "position"
    t.integer  "ordering",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menus", ["menu_id"], name: "index_menus_on_menu_id"
  add_index "menus", ["menu_type_id"], name: "index_menus_on_menu_type_id"
  add_index "menus", ["page_id"], name: "index_menus_on_page_id"

  create_table "messages", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
    t.string   "alipay_trade_no"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "orders_logs", force: true do |t|
    t.integer  "order_id"
    t.integer  "admin_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  add_index "orders_logs", ["admin_id"], name: "index_orders_logs_on_admin_id"
  add_index "orders_logs", ["order_id"], name: "index_orders_logs_on_order_id"

  create_table "orders_products", force: true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.decimal  "price"
    t.text     "snapshot"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number"
  end

  add_index "orders_products", ["order_id"], name: "index_orders_products_on_order_id"
  add_index "orders_products", ["product_id"], name: "index_orders_products_on_product_id"

  create_table "pages", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "menu_id"
  end

  add_index "pages", ["menu_id"], name: "index_pages_on_menu_id"

  create_table "products", force: true do |t|
    t.string   "title"
    t.string   "introduction"
    t.text     "description"
    t.text     "information"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ordering"
    t.integer  "price"
    t.string   "link"
  end

  create_table "products_images", force: true do |t|
    t.integer  "product_id"
    t.integer  "ordering"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "products_images", ["product_id"], name: "index_products_images_on_product_id"

  create_table "profiles", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "phone"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
