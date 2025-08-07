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

ActiveRecord::Schema[7.1].define(version: 2025_08_07_142535) do
  create_table "location_groups", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "description"
    t.bigint "location_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_group_id"], name: "index_locations_on_location_group_id"
  end

  create_table "products", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "sku"
    t.text "description"
    t.integer "stock"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "description"
    t.boolean "is_active"
    t.boolean "is_billable"
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_service_types_on_team_id"
  end

  create_table "team_memberships", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_memberships_on_team_id"
    t.index ["user_id"], name: "index_team_memberships_on_user_id"
  end

  create_table "teams", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "description"
    t.bigint "boss_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["boss_id"], name: "index_teams_on_boss_id"
  end

  create_table "ticket_comments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "description"
    t.bigint "ticket_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_ticket_comments_on_ticket_id"
    t.index ["user_id"], name: "index_ticket_comments_on_user_id"
  end

  create_table "ticket_products", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "quantity"
    t.text "observation"
    t.bigint "ticket_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_ticket_products_on_product_id"
    t.index ["ticket_id"], name: "index_ticket_products_on_ticket_id"
  end

  create_table "ticket_status_logs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "observation"
    t.bigint "user_id", null: false
    t.bigint "ticket_id", null: false
    t.bigint "previous_status_id", null: false
    t.bigint "new_status_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["new_status_id"], name: "index_ticket_status_logs_on_new_status_id"
    t.index ["previous_status_id"], name: "index_ticket_status_logs_on_previous_status_id"
    t.index ["ticket_id"], name: "index_ticket_status_logs_on_ticket_id"
    t.index ["user_id"], name: "index_ticket_status_logs_on_user_id"
  end

  create_table "ticket_statuses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "priority"
    t.string "type_ticket"
    t.string "contact_name"
    t.string "contact_phone"
    t.datetime "scheduled_date"
    t.datetime "arrived_date"
    t.datetime "start_service_date"
    t.datetime "end_service_date"
    t.float "total_hour_service"
    t.text "technical_observation"
    t.decimal "longitude_arrived", precision: 10
    t.decimal "latitude_arrived", precision: 10
    t.decimal "longitude_end_work", precision: 10
    t.decimal "latitude_end_work", precision: 10
    t.decimal "cost", precision: 10
    t.bigint "team_id", null: false
    t.bigint "status_id", null: false
    t.bigint "created_by_id", null: false
    t.bigint "assigned_to_id"
    t.bigint "location_id", null: false
    t.bigint "service_type_id", null: false
    t.bigint "location_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "billable"
    t.integer "billing_status"
    t.text "invoice_details"
    t.text "invoice_contact_name"
    t.text "invoice_contact_ruc"
    t.datetime "invoice_generate_date"
    t.datetime "invoice_payment_date"
    t.index ["assigned_to_id"], name: "index_tickets_on_assigned_to_id"
    t.index ["created_by_id"], name: "index_tickets_on_created_by_id"
    t.index ["location_group_id"], name: "index_tickets_on_location_group_id"
    t.index ["location_id"], name: "index_tickets_on_location_id"
    t.index ["service_type_id"], name: "index_tickets_on_service_type_id"
    t.index ["status_id"], name: "index_tickets_on_status_id"
    t.index ["team_id"], name: "index_tickets_on_team_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "locations", "location_groups"
  add_foreign_key "service_types", "teams"
  add_foreign_key "team_memberships", "teams"
  add_foreign_key "team_memberships", "users"
  add_foreign_key "teams", "users", column: "boss_id"
  add_foreign_key "ticket_comments", "tickets"
  add_foreign_key "ticket_comments", "users"
  add_foreign_key "ticket_products", "products"
  add_foreign_key "ticket_products", "tickets"
  add_foreign_key "ticket_status_logs", "ticket_statuses", column: "new_status_id"
  add_foreign_key "ticket_status_logs", "ticket_statuses", column: "previous_status_id"
  add_foreign_key "ticket_status_logs", "tickets"
  add_foreign_key "ticket_status_logs", "users"
  add_foreign_key "tickets", "location_groups"
  add_foreign_key "tickets", "locations"
  add_foreign_key "tickets", "service_types"
  add_foreign_key "tickets", "teams"
  add_foreign_key "tickets", "ticket_statuses", column: "status_id"
  add_foreign_key "tickets", "users", column: "assigned_to_id"
  add_foreign_key "tickets", "users", column: "created_by_id"
end
