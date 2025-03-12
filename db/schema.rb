# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_25_214144) do
  create_table "fines", force: :cascade do |t|
    t.integer "loan_id", null: false
    t.integer "user_id", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.boolean "paid", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "unpaid"
    t.index ["loan_id"], name: "index_fines_on_loan_id"
    t.index ["user_id"], name: "index_fines_on_user_id"
  end

  create_table "loans", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "resource_id", null: false
    t.datetime "loan_date", null: false
    t.datetime "due_date", null: false
    t.datetime "return_date"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_id"], name: "index_loans_on_resource_id"
    t.index ["user_id"], name: "index_loans_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "resource_id", null: false
    t.datetime "reservation_date", null: false
    t.datetime "expiration_date", null: false
    t.string "status", default: "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_id"], name: "index_reservations_on_resource_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "title", null: false
    t.integer "publish_year", null: false
    t.string "language", null: false
    t.string "publisher"
    t.text "description"
    t.string "type"
    t.string "author"
    t.integer "volume"
    t.integer "issue"
    t.string "category", null: false
    t.boolean "available", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "surname", null: false
    t.string "contact_address"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "user_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "fines", "loans"
  add_foreign_key "fines", "users"
  add_foreign_key "loans", "resources"
  add_foreign_key "loans", "users"
  add_foreign_key "reservations", "resources"
  add_foreign_key "reservations", "users"
end
