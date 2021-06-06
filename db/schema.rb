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

ActiveRecord::Schema.define(version: 2021_06_06_142924) do

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "offer_departments", force: :cascade do |t|
    t.integer "offer_id", null: false
    t.integer "department_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_offer_departments_on_department_id"
    t.index ["offer_id"], name: "index_offer_departments_on_offer_id"
  end

  create_table "offers", force: :cascade do |t|
    t.integer "price", null: false
    t.string "company", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "public_id"
    t.boolean "from_external_api", default: false
  end

  create_table "user_departments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "department_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_user_departments_on_department_id"
    t.index ["user_id"], name: "index_user_departments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "company", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "offer_departments", "departments"
  add_foreign_key "offer_departments", "offers"
  add_foreign_key "user_departments", "departments"
  add_foreign_key "user_departments", "users"
end
