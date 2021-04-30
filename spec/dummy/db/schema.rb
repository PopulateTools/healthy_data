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

ActiveRecord::Schema.define(version: 2021_04_30_110641) do

  create_table "healthy_data_item_checks", force: :cascade do |t|
    t.datetime "checked_at"
    t.string "checkable_type"
    t.integer "checkable_id"
    t.string "rule"
    t.string "result"
    t.boolean "solved", default: false
    t.json "args", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["checkable_type", "checkable_id"], name: "idx_healthy_data_item_checks_on_checkable"
    t.index ["checkable_type", "checkable_id"], name: "index_healthy_data_item_checks_on_checkable"
    t.index ["rule"], name: "index_healthy_data_item_checks_on_rule"
  end

  create_table "items", force: :cascade do |t|
    t.integer "amount"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
