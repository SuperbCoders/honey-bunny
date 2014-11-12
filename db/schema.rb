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

ActiveRecord::Schema.define(version: 20141112181654) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "block_charts", force: true do |t|
    t.integer  "block_id"
    t.integer  "value"
    t.string   "title"
    t.string   "color"
    t.boolean  "inverse_font_color", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "block_charts", ["block_id"], name: "index_block_charts_on_block_id", using: :btree

  create_table "block_elements", force: true do |t|
    t.integer  "block_id"
    t.string   "image"
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "block_elements", ["block_id"], name: "index_block_elements_on_block_id", using: :btree

  create_table "block_images", force: true do |t|
    t.integer  "block_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "block_images", ["block_id"], name: "index_block_images_on_block_id", using: :btree

  create_table "blocks", force: true do |t|
    t.string   "blockable_type"
    t.integer  "blockable_id"
    t.integer  "position"
    t.string   "template"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blocks", ["blockable_type", "blockable_id"], name: "index_blocks_on_blockable_type_and_blockable_id", using: :btree

  create_table "blocks_items", force: true do |t|
    t.integer "block_id"
    t.integer "item_id"
  end

  add_index "blocks_items", ["block_id", "item_id"], name: "index_blocks_items_on_block_id_and_item_id", unique: true, using: :btree
  add_index "blocks_items", ["block_id"], name: "index_blocks_items_on_block_id", using: :btree
  add_index "blocks_items", ["item_id"], name: "index_blocks_items_on_item_id", using: :btree

  create_table "cart_items", force: true do |t|
    t.integer  "cart_id"
    t.integer  "item_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cart_items", ["cart_id", "item_id"], name: "index_cart_items_on_cart_id_and_item_id", unique: true, using: :btree
  add_index "cart_items", ["cart_id"], name: "index_cart_items_on_cart_id", using: :btree
  add_index "cart_items", ["item_id"], name: "index_cart_items_on_item_id", using: :btree

  create_table "carts", force: true do |t|
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["name"], name: "index_cities_on_name", unique: true, using: :btree

  create_table "faqs", force: true do |t|
    t.text     "question"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["provider", "uid"], name: "index_identities_on_provider_and_uid", unique: true, using: :btree
  add_index "identities", ["provider", "user_id"], name: "index_identities_on_provider_and_user_id", unique: true, using: :btree
  add_index "identities", ["provider"], name: "index_identities_on_provider", using: :btree
  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "items", force: true do |t|
    t.string   "title"
    t.string   "main_image"
    t.string   "motto"
    t.integer  "volume"
    t.text     "short_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price_cents",               default: 0,     null: false
    t.string   "price_currency",            default: "RUB", null: false
    t.integer  "quantity",                  default: 0
    t.boolean  "negative_quantity_allowed", default: false
    t.datetime "deleted_at"
  end

  add_index "items", ["deleted_at"], name: "index_items_on_deleted_at", using: :btree

  create_table "items_reviews", force: true do |t|
    t.integer "item_id"
    t.integer "review_id"
  end

  add_index "items_reviews", ["item_id"], name: "index_items_reviews_on_item_id", using: :btree
  add_index "items_reviews", ["review_id", "item_id"], name: "index_items_reviews_on_review_id_and_item_id", unique: true, using: :btree
  add_index "items_reviews", ["review_id"], name: "index_items_reviews_on_review_id", using: :btree

  create_table "meta_blocks", force: true do |t|
    t.integer  "meta_blockable_id"
    t.string   "meta_blockable_type"
    t.string   "title"
    t.text     "description"
    t.text     "keywords"
    t.text     "javascript"
    t.string   "fb_image"
    t.string   "fb_title"
    t.text     "fb_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meta_blocks", ["meta_blockable_id", "meta_blockable_type"], name: "index_meta_blocks_on_meta_blockable_id_and_meta_blockable_type", using: :btree

  create_table "order_items", force: true do |t|
    t.integer  "order_id"
    t.integer  "item_id"
    t.integer  "price_cents",    default: 0,     null: false
    t.string   "price_currency", default: "RUB", null: false
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_items", ["item_id"], name: "index_order_items_on_item_id", using: :btree
  add_index "order_items", ["order_id", "item_id"], name: "index_order_items_on_order_id_and_item_id", unique: true, using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "shipping_method_id"
    t.integer  "payment_method_id"
    t.string   "workflow_state"
    t.boolean  "paid",                    default: false
    t.string   "city"
    t.string   "zipcode"
    t.text     "address"
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.text     "comment"
    t.integer  "shipping_price_cents",    default: 0,     null: false
    t.string   "shipping_price_currency", default: "RUB", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["payment_method_id"], name: "index_orders_on_payment_method_id", using: :btree
  add_index "orders", ["shipping_method_id"], name: "index_orders_on_shipping_method_id", using: :btree

  create_table "pages", force: true do |t|
    t.string   "slug"
    t.string   "title"
    t.text     "text"
    t.boolean  "published",  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cover"
    t.string   "motto"
    t.string   "subtitle"
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "payment_methods", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payment_methods", ["name"], name: "index_payment_methods_on_name", unique: true, using: :btree

  create_table "questions", force: true do |t|
    t.integer  "user_id"
    t.text     "text"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id", using: :btree

  create_table "reviews", force: true do |t|
    t.integer  "user_id"
    t.integer  "rating"
    t.string   "name"
    t.string   "email"
    t.string   "city"
    t.text     "message"
    t.string   "workflow_state"
    t.string   "place"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "shipping_methods", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "rate_type"
    t.integer  "rate_cents",            default: 0,     null: false
    t.string   "rate_currency",         default: "RUB", null: false
    t.integer  "extra_charge_cents",    default: 0,     null: false
    t.string   "extra_charge_currency", default: "RUB", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority"
  end

  add_index "shipping_methods", ["name"], name: "index_shipping_methods_on_name", unique: true, using: :btree

  create_table "shipping_prices", force: true do |t|
    t.integer  "city_id"
    t.integer  "shipping_method_id"
    t.integer  "price_cents",        default: 0,     null: false
    t.string   "price_currency",     default: "RUB", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shipping_prices", ["city_id"], name: "index_shipping_prices_on_city_id", using: :btree
  add_index "shipping_prices", ["shipping_method_id", "city_id"], name: "index_shipping_prices_on_shipping_method_id_and_city_id", unique: true, using: :btree
  add_index "shipping_prices", ["shipping_method_id"], name: "index_shipping_prices_on_shipping_method_id", using: :btree

  create_table "shops", force: true do |t|
    t.string   "logo"
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.string   "lat"
    t.string   "lon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "name"
    t.string   "avatar"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
