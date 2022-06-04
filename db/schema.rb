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

ActiveRecord::Schema[7.0].define(version: 2022_06_04_232445) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "airports", force: :cascade do |t|
    t.string "code", limit: 3, null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "time_zone_info_id"
    t.decimal "latitude", null: false
    t.decimal "longitude", null: false
    t.index ["code"], name: "index_airports_on_code", unique: true
    t.index ["time_zone_info_id"], name: "index_airports_on_time_zone_info_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "flight_id", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.string "confirmation_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_code"], name: "index_bookings_on_confirmation_code", unique: true
    t.index ["flight_id"], name: "index_bookings_on_flight_id"
  end

  create_table "flights", force: :cascade do |t|
    t.bigint "departure_airport_id", null: false
    t.bigint "arrival_airport_id", null: false
    t.datetime "departure_datetime", null: false
    t.integer "duration", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["arrival_airport_id"], name: "index_flights_on_arrival_airport_id"
    t.index ["departure_airport_id"], name: "index_flights_on_departure_airport_id"
  end

  create_table "passengers", force: :cascade do |t|
    t.bigint "booking_id", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_passengers_on_booking_id"
  end

  create_table "time_zone_infos", force: :cascade do |t|
    t.string "rails_time_zone", null: false
    t.string "iana_time_zone", null: false
    t.integer "standard_utc_offset_hours", null: false
    t.integer "daylight_savings_utc_offset_hours", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "airports", "time_zone_infos"
  add_foreign_key "bookings", "flights"
  add_foreign_key "flights", "airports", column: "arrival_airport_id"
  add_foreign_key "flights", "airports", column: "departure_airport_id"
  add_foreign_key "passengers", "bookings"
end
