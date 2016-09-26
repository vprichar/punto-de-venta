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

ActiveRecord::Schema.define(version: 20160629214949) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "username",               default: "", null: false
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
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "cash_outs", force: true do |t|
    t.integer  "user_id"
    t.decimal  "total_price"
    t.integer  "total_sales"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_address"
    t.string   "phone_number"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "published",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", force: true do |t|
    t.string   "name"
    t.string   "rfc"
    t.string   "address"
    t.integer  "phone"
    t.string   "email"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.string   "sku"
    t.string   "name"
    t.text     "description"
    t.decimal  "price",            precision: 8, scale: 2
    t.integer  "stock_amount"
    t.integer  "amount_sold",                              default: 0
    t.decimal  "cost_price",       precision: 8, scale: 2
    t.boolean  "published",                                default: true
    t.string   "model"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_category_id"
    t.integer  "purchaseorder_id"
  end

  create_table "line_items", force: true do |t|
    t.integer  "item_id"
    t.integer  "quantity",                            default: 1
    t.decimal  "price",       precision: 8, scale: 2
    t.decimal  "total_price", precision: 8, scale: 2
    t.integer  "sale_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "discount",    precision: 8, scale: 2
  end

  create_table "payments", force: true do |t|
    t.integer  "sale_id"
    t.decimal  "amount",       precision: 8, scale: 2
    t.string   "payment_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchaseorder_items", force: true do |t|
    t.integer  "item_id"
    t.integer  "purchaseorder_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchaseorders", force: true do |t|
    t.string   "store_configuration_id"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "committed"
  end

  create_table "retails", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "phone"
    t.boolean  "status"
    t.integer  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sale_reports", force: true do |t|
    t.string   "name"
    t.integer  "store_configuration_id"
    t.date     "initial_date"
    t.date     "final_date"
    t.integer  "total_sales_number"
    t.decimal  "total_cash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales", force: true do |t|
    t.decimal  "amount",                 precision: 8, scale: 2
    t.decimal  "total_amount",           precision: 8, scale: 2
    t.decimal  "remaining_amount"
    t.decimal  "discount",               precision: 8, scale: 2
    t.decimal  "tax",                    precision: 8, scale: 2
    t.integer  "customer_id"
    t.text     "comments"
    t.decimal  "estatus"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "employee_id"
    t.integer  "cash_out_id"
    t.boolean  "cut"
    t.integer  "store_configuration_id"
    t.integer  "stock_id"
    t.datetime "date"
  end

  create_table "stocks", force: true do |t|
    t.integer  "quantity"
    t.integer  "rank"
    t.integer  "store_configuration_id"
    t.integer  "item_id"
    t.integer  "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_configurations", force: true do |t|
    t.string   "store_name"
    t.text     "store_description"
    t.string   "email_address"
    t.string   "phone_number"
    t.string   "website_url"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "currency"
    t.decimal  "tax_rate",          precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "token"
  end

  create_table "users", force: true do |t|
    t.string   "username",                 default: "",    null: false
    t.string   "email",                    default: "",    null: false
    t.string   "encrypted_password",       default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "can_update_users",         default: false
    t.boolean  "can_update_items",         default: true
    t.boolean  "can_update_configuration", default: false
    t.boolean  "can_view_reports",         default: false
    t.boolean  "can_update_sale_discount", default: false
    t.boolean  "can_remove_sales",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_configuration_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
