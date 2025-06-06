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

ActiveRecord::Schema[8.0].define(version: 2025_06_06_163853) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bills", force: :cascade do |t|
    t.bigint "customer_profile_id", null: false
    t.bigint "water_reading_id", null: false
    t.decimal "amount"
    t.date "due_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_profile_id"], name: "index_bills_on_customer_profile_id"
    t.index ["water_reading_id"], name: "index_bills_on_water_reading_id"
  end

  create_table "customer_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "meter_number"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_customer_profiles_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "bill_id", null: false
    t.decimal "amount"
    t.string "payment_method"
    t.string "transaction_code"
    t.datetime "paid_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bill_id"], name: "index_payments_on_bill_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "email"
    t.integer "role"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "water_readings", force: :cascade do |t|
    t.bigint "customer_profile_id", null: false
    t.date "reading_date"
    t.decimal "consumption"
    t.boolean "billed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_profile_id"], name: "index_water_readings_on_customer_profile_id"
  end

  add_foreign_key "bills", "customer_profiles"
  add_foreign_key "bills", "water_readings"
  add_foreign_key "customer_profiles", "users"
  add_foreign_key "payments", "bills"
  add_foreign_key "water_readings", "customer_profiles"
end
