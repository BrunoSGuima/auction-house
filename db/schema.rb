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

ActiveRecord::Schema[7.0].define(version: 2023_05_08_231526) do
  create_table "auction_approvals", force: :cascade do |t|
    t.integer "auction_lot_id", null: false
    t.integer "approved_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["approved_by_id"], name: "index_auction_approvals_on_approved_by_id"
    t.index ["auction_lot_id"], name: "index_auction_approvals_on_auction_lot_id"
  end

  create_table "auction_items", force: :cascade do |t|
    t.integer "product_model_id", null: false
    t.integer "auction_lot_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auction_lot_id"], name: "index_auction_items_on_auction_lot_id"
    t.index ["product_model_id"], name: "index_auction_items_on_product_model_id"
  end

  create_table "auction_lots", force: :cascade do |t|
    t.string "code"
    t.datetime "start_date"
    t.datetime "limit_date"
    t.integer "value_min"
    t.integer "diff_min"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_auction_lots_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_products", force: :cascade do |t|
    t.integer "auction_lot_id", null: false
    t.integer "product_model_id", null: false
    t.string "serial_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "auction_item_id", null: false
    t.index ["auction_item_id"], name: "index_item_products_on_auction_item_id"
    t.index ["auction_lot_id"], name: "index_item_products_on_auction_lot_id"
    t.index ["product_model_id"], name: "index_item_products_on_product_model_id"
  end

  create_table "product_models", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "weight"
    t.integer "width"
    t.integer "height"
    t.integer "depth"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.integer "category_id", null: false
    t.index ["category_id"], name: "index_product_models_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "auction_approvals", "auction_lots"
  add_foreign_key "auction_approvals", "users", column: "approved_by_id"
  add_foreign_key "auction_items", "auction_lots"
  add_foreign_key "auction_items", "product_models"
  add_foreign_key "auction_lots", "users"
  add_foreign_key "item_products", "auction_items"
  add_foreign_key "item_products", "auction_lots"
  add_foreign_key "item_products", "product_models"
  add_foreign_key "product_models", "categories"
end
