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

ActiveRecord::Schema.define(version: 20130813002753) do

  create_table "list_of_works_categories", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "list_of_works_categories_orders", force: true do |t|
    t.integer "order_id"
    t.integer "list_of_works_category_id"
  end

  create_table "orders", force: true do |t|
    t.integer  "type_of_certificate_id"
    t.integer  "type_of_legal_entity_id"
    t.integer  "status_id"
    t.string   "company"
    t.string   "creator_name"
    t.string   "registered_address"
    t.string   "actual_address"
    t.string   "address_on_english"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.string   "inn"
    t.string   "kpp"
    t.string   "ogrn"
    t.string   "bank"
    t.string   "current_account"
    t.string   "correspondent_account"
    t.string   "bik"
    t.string   "bank_person"
    t.string   "auditors_names"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "type_of_certificates", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "type_of_legal_entities", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_title"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.integer  "permission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
