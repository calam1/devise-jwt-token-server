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

ActiveRecord::Schema.define(version: 2020_07_28_214916) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "btree_gin"
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

  create_table "act_on_access_tokens", id: :serial, force: :cascade do |t|
    t.string "token_type", limit: 255
    t.string "string", limit: 255
    t.string "refresh_token", limit: 255
    t.string "access_token", limit: 255
    t.integer "expires_in"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addon_types", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "display_name"
    t.string "container_type"
    t.boolean "vendor_supplied", default: false, null: false
    t.integer "price_in_cents", default: 0
    t.boolean "enabled", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sorting_order", default: 0
    t.integer "max", default: 0
    t.text "check_lists", default: [], array: true
  end

  create_table "addresses", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "address", limit: 255
    t.string "apartment", limit: 255
    t.string "city", limit: 255
    t.string "state", limit: 255
    t.string "zip", limit: 255
    t.string "phone", limit: 255
    t.text "delivery_instructions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "delivery_type", limit: 255
    t.string "shipping_type", limit: 255
    t.integer "validation_status", default: 2
    t.json "suggestions"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "allergens", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "allergens_meal_options", id: :serial, force: :cascade do |t|
    t.integer "allergen_id"
    t.integer "meal_option_id"
  end

  create_table "analytics_snapshots", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "user_type", limit: 255
    t.integer "analytics_id"
    t.integer "analytics_source", null: false
    t.jsonb "properties", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "current", default: true, null: false
    t.index ["analytics_id", "analytics_source"], name: "index_analytics_snapshots_on_analytics_id_and_analytics_source", unique: true
    t.index ["user_type", "user_id", "analytics_source"], name: "index_analytics_snapshots_on_user_and_analytics_source", unique: true
  end

  create_table "avalara_failure_logs", id: :serial, force: :cascade do |t|
    t.integer "orderable_id"
    t.string "orderable_type"
    t.string "error_from"
    t.text "error_message"
    t.text "error_backtrace"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["orderable_type", "orderable_id"], name: "index_avalara_failure_logs_on_orderable_type_and_orderable_id"
  end

  create_table "bank_logs", id: :serial, force: :cascade do |t|
    t.integer "bank_id"
    t.integer "amount_cents"
    t.integer "bank_loggable_id"
    t.string "bank_loggable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "remaining_balance_cents", default: 0
    t.text "reason"
    t.string "description", limit: 255
    t.integer "integration_type"
    t.index ["bank_id"], name: "index_bank_logs_on_bank_id"
    t.index ["bank_loggable_id", "bank_loggable_type"], name: "index_bank_logs_on_bank_loggable_id_and_bank_loggable_type"
  end

  create_table "bank_logs_pending_referrals", id: :serial, force: :cascade do |t|
    t.integer "bank_id"
    t.integer "amount_in_cents"
    t.string "bank_loggable_type", limit: 255, default: "referral_pending"
    t.datetime "fulfillment_at"
    t.string "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banks", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "balance_cents", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_banks_on_user_id"
  end

  create_table "basket_events", id: :serial, force: :cascade do |t|
    t.string "aggregate_id", limit: 255, null: false
    t.binary "data"
    t.integer "version"
    t.index ["aggregate_id", "version"], name: "idx_basket_events", unique: true
  end

  create_table "basket_item_addons", id: :serial, force: :cascade do |t|
    t.integer "menu_item_id"
    t.integer "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "basket_id"
  end

  create_table "basket_items", id: :serial, force: :cascade do |t|
    t.integer "basket_id"
    t.integer "menu_item_id"
    t.integer "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["basket_id"], name: "index_basket_items_on_basket_id"
  end

  create_table "basket_modification_histories", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "basket_id"
    t.integer "basket_status"
    t.integer "meal_option_id"
    t.integer "product_id"
    t.integer "menu_item_id"
    t.integer "menu_id"
    t.string "direction", limit: 255
    t.integer "previous_meal_quantity"
    t.integer "new_meal_quantity"
    t.integer "quantity_change"
    t.integer "order_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "modified_by_admin", default: false
    t.string "modified_by", limit: 255
    t.index ["basket_id"], name: "index_basket_modification_histories_on_basket_id"
    t.index ["user_id", "meal_option_id"], name: "index_basket_modification_histories_on_user_and_meal_option"
    t.index ["user_id", "menu_id"], name: "index_basket_modification_histories_on_user_id_and_menu_id"
    t.index ["user_id", "product_id"], name: "index_basket_modification_histories_on_user_id_and_product_id"
    t.index ["user_id"], name: "index_basket_modification_histories_on_user_id"
  end

  create_table "basket_pause_histories", id: :serial, force: :cascade do |t|
    t.integer "basket_id"
    t.integer "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["basket_id"], name: "basket_pause_histories_basket_id"
  end

  create_table "basket_plan_deliveries", id: :serial, force: :cascade do |t|
    t.integer "basket_plan_id"
    t.string "shipping_type", limit: 255
    t.integer "price_in_cents"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "delivery_method_id"
    t.index ["delivery_method_id"], name: "index_basket_plan_deliveries_on_delivery_method_id"
  end

  create_table "basket_plans", id: :serial, force: :cascade do |t|
    t.integer "size"
    t.integer "pricing_grid_id"
    t.integer "price_in_cents"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "plan_tier_id"
    t.integer "highlight", default: 0, null: false
  end

  create_table "basket_status_histories", id: :serial, force: :cascade do |t|
    t.integer "active"
    t.integer "paused"
    t.integer "on_hold"
    t.integer "order_placed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "baskets", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "subscription_id"
    t.integer "menu_id"
    t.integer "credit_card_id"
    t.integer "address_id"
    t.date "delivery_date"
    t.integer "basket_plan_id"
    t.integer "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "order_id"
    t.integer "coupon_id"
    t.integer "kitchen_id"
    t.integer "order_auth_id"
    t.text "packing_sheet_instruction"
    t.datetime "paused_on"
    t.integer "step_coupon_id"
    t.bigint "tax_in_pennies"
    t.string "avalara_transaction_id"
    t.string "avalara_transaction_code"
    t.float "tax_rate", default: 0.0
    t.boolean "viewed", default: false
    t.index ["kitchen_id"], name: "index_baskets_on_kitchen_id"
    t.index ["order_auth_id"], name: "index_baskets_on_order_auth_id"
    t.index ["order_id"], name: "basket_order_id"
    t.index ["subscription_id", "menu_id"], name: "index_baskets_on_subscription_id_and_menu_id", unique: true
  end

  create_table "box_configurations", id: :serial, force: :cascade do |t|
    t.integer "basket_plan_id"
    t.integer "total_add_ons", default: 0
    t.integer "extra_small_box", default: 0
    t.integer "small_box", default: 0
    t.integer "medium_box", default: 0
    t.integer "large_box", default: 0
    t.integer "extra_large_box", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "delivery_method_category_id"
  end

  create_table "box_sizes", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
  end

  create_table "box_weights", id: :serial, force: :cascade do |t|
    t.integer "delivery_method_category_id"
    t.integer "box_size_id"
    t.string "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["box_size_id"], name: "index_box_weights_on_box_size_id"
    t.index ["delivery_method_category_id"], name: "index_box_weights_on_delivery_method_category_id"
  end

  create_table "cancellations", id: :serial, force: :cascade do |t|
    t.integer "meal_plan_id"
    t.string "reason", limit: 255
    t.text "explanation"
    t.boolean "follow_up"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json "properties", default: {}
    t.string "sub_reason", limit: 255
    t.integer "subscription_id"
    t.index ["meal_plan_id"], name: "index_cancellations_on_meal_plan_id"
  end

  create_table "cart_item_addons", id: :serial, force: :cascade do |t|
    t.string "parent_type"
    t.integer "parent_id"
    t.integer "product_size_id"
    t.integer "meal_option_id"
    t.integer "menu_item_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cart_items", id: :serial, force: :cascade do |t|
    t.integer "parent_id"
    t.integer "product_size_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "parent_type", limit: 255
    t.integer "meal_option_id"
    t.boolean "freebie"
    t.integer "menu_item_id"
    t.index ["parent_id"], name: "index_cart_items_on_parent_id"
    t.index ["product_size_id"], name: "index_cart_items_on_product_size_id"
  end

  create_table "cart_modification_histories", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "meal_plan_id"
    t.integer "meal_option_id"
    t.integer "product_id"
    t.integer "menu_item_id"
    t.integer "menu_id"
    t.string "direction", limit: 255
    t.integer "previous_meal_quantity"
    t.integer "new_meal_quantity"
    t.integer "quantity_change"
    t.integer "order_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "meal_plan_status"
  end

  create_table "carts", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "coupon_code_id"
    t.integer "discount_in_pennies"
    t.string "discount_currency", limit: 255, default: "USD"
    t.integer "user_id"
    t.integer "zip_code_id"
    t.integer "coupon_id"
    t.datetime "deleted_at"
    t.bigint "tax_in_pennies"
    t.string "avalara_transaction_id"
    t.string "avalara_transaction_code"
    t.float "tax_rate", default: 0.0
    t.index ["coupon_code_id"], name: "index_carts_on_coupon_code_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "meta_title", limit: 255
    t.text "meta_description"
    t.text "body"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug", limit: 255
    t.string "context", limit: 255
    t.string "icon", limit: 255
    t.index ["slug"], name: "index_categories_on_slug"
  end

  create_table "categories_products", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "product_id"
    t.index ["category_id", "product_id"], name: "index_categories_products_on_category_id_and_product_id"
  end

  create_table "containers", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "content_actions", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "optin_name", limit: 255
    t.string "optin_details", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "optin_type", limit: 255
    t.index ["user_id"], name: "index_content_actions_on_user_id"
  end

  create_table "coupon_categories", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coupon_freebies", id: :serial, force: :cascade do |t|
    t.integer "coupon_id", null: false
    t.string "product_size_id", limit: 255
    t.integer "count", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "meal_option_id"
    t.index ["coupon_id"], name: "index_coupon_freebies_on_coupon_id"
    t.index ["product_size_id"], name: "index_coupon_freebies_on_product_size_id"
  end

  create_table "coupon_redemptions", id: :serial, force: :cascade do |t|
    t.integer "coupon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id"
    t.integer "user_id"
    t.datetime "end_date"
    t.datetime "deleted_at"
    t.index ["coupon_id"], name: "index_coupon_redemptions_on_coupon_id"
    t.index ["order_id"], name: "index_coupon_redemptions_on_order_id"
  end

  create_table "coupons", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.boolean "active"
    t.integer "discount_amount_cents", default: 0, null: false
    t.string "discount_amount_currency", limit: 255, default: "USD", null: false
    t.integer "discount_percentage", default: 0, null: false
    t.integer "minimum_purchase_cents", default: 0, null: false
    t.string "minimum_purchase_currency", limit: 255, default: "USD", null: false
    t.integer "minimum_items", default: 0, null: false
    t.string "domains", limit: 1000
    t.datetime "starts"
    t.datetime "ends"
    t.integer "ttl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.money "maximum_purchase", scale: 2, default: "0.0", null: false
    t.integer "maximum_items", default: 0, null: false
    t.string "rep_email", limit: 255
    t.integer "usage_limit"
    t.integer "category_id"
    t.integer "min_order_count", default: 0
    t.integer "max_order_count", default: 0
    t.integer "redemption_number_of_weeks"
    t.boolean "discount_free_delivery"
    t.string "description", limit: 255
    t.integer "user_eligibility", default: 1, null: false
    t.boolean "is_one_time", default: false
    t.boolean "is_one_time_redeemed", default: false
    t.boolean "is_step_coupon", default: false
    t.integer "discount_type"
    t.index ["active"], name: "index_coupons_on_active"
    t.index ["name"], name: "index_coupons_on_name"
  end

  create_table "credit_cards", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "stripe_cc_id", limit: 255
    t.string "last4", limit: 255
    t.string "cc_type", limit: 255
    t.integer "exp_month"
    t.integer "exp_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.integer "declined_count", default: 0
    t.boolean "is_primary_card", default: false
    t.string "fingerprint"
    t.index ["stripe_cc_id"], name: "index_credit_cards_on_stripe_cc_id"
    t.index ["user_id"], name: "index_credit_cards_on_user_id"
  end

  create_table "customer_testimonials", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.text "quote"
    t.string "title", limit: 255
    t.string "headshot_image", limit: 255
    t.integer "row_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delivery_charge_experiment_users", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "zip_code", limit: 255
    t.integer "group"
    t.boolean "existing_when_added", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delivery_dates", id: :serial, force: :cascade do |t|
    t.integer "menu_id"
    t.date "delivery_date"
    t.string "shipping_type", limit: 255
    t.date "ship_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "delivery_method_id"
    t.index ["delivery_method_id"], name: "index_delivery_dates_on_delivery_method_id"
    t.index ["menu_id"], name: "index_delivery_dates_on_menu_id"
  end

  create_table "delivery_method_categories", id: :serial, force: :cascade do |t|
    t.string "category", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
  end

  create_table "delivery_methods", id: :serial, force: :cascade do |t|
    t.string "slug", limit: 255, null: false
    t.string "name", limit: 255, null: false
    t.string "courier", limit: 255, null: false
    t.integer "days_to_ship", null: false
    t.integer "default_delivery_day_of_week", null: false
    t.boolean "active", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "delivery_method_category_id"
    t.boolean "global_override", default: false
    t.index ["name"], name: "index_delivery_methods_on_name"
    t.index ["slug"], name: "index_delivery_methods_on_slug", unique: true
  end

  create_table "delivery_prices", id: :serial, force: :cascade do |t|
    t.integer "min_spend_cents"
    t.integer "max_spend_cents"
    t.integer "price_cents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "disliked_meals", id: :serial, force: :cascade do |t|
    t.integer "meal_option_id"
    t.integer "taste_profile_id"
    t.text "feedback"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["taste_profile_id"], name: "index_disliked_meals_on_taste_profile_id"
  end

  create_table "email_newsletters", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "source", limit: 255
    t.index ["email"], name: "index_email_newsletters_on_email"
  end

  create_table "favorites", id: :serial, force: :cascade do |t|
    t.integer "taste_profile_id"
    t.integer "meal_option_id"
    t.integer "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["meal_option_id"], name: "index_favorites_on_meal_option_id"
    t.index ["taste_profile_id"], name: "index_favorites_on_taste_profile_id"
  end

  create_table "fedex_chicago_routes", id: :serial, force: :cascade do |t|
    t.string "DL_state"
    t.string "to_zip"
    t.integer "current_delivery_method_id"
    t.integer "tnt"
    t.integer "zip_codes_direct_line_id"
    t.integer "best_option_out_of_chicago_delivery_method_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["to_zip"], name: "index_fedex_chicago_routes_on_to_zip"
  end

  create_table "gel_pack_configurations", id: :serial, force: :cascade do |t|
    t.integer "box_configuration_id"
    t.integer "box_size_id"
    t.integer "total_48_oz", default: 0, null: false
    t.integer "total_80_oz", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "delivery_method_category_id"
    t.integer "total_box", default: 0
  end

  create_table "gel_pack_configurations_for_direct_lines", id: :serial, force: :cascade do |t|
    t.integer "zip_codes_direct_line_id"
    t.integer "box_size_id"
    t.integer "total_48_oz", default: 0, null: false
    t.integer "total_80_oz", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gift_box_invitations", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "gift_box_invitee_id"
    t.string "gift_box_invitee_email_address"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "gift_box_referral_id"
    t.string "unique_code"
    t.boolean "expired", default: false
    t.index ["user_id"], name: "index_gift_box_invitations_on_user_id"
  end

  create_table "gift_box_referrals", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gift_cards", id: :serial, force: :cascade do |t|
    t.integer "gifter_id"
    t.string "gifter_name", limit: 255
    t.integer "recipient_id"
    t.string "recipient_email", limit: 255
    t.integer "amount_cents"
    t.text "message"
    t.string "token", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "paid", default: false
    t.string "promo", limit: 255
    t.index ["gifter_id"], name: "index_gift_cards_on_gifter_id"
    t.index ["recipient_id"], name: "index_gift_cards_on_recipient_id"
  end

  create_table "global_special_instructions", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.text "packing_sheet_instruction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holiday_delivery_overrides", id: :serial, force: :cascade do |t|
    t.integer "menu_id", null: false
    t.integer "zip_codes_direct_line_id"
    t.integer "holiday_zip_codes_direct_line_id"
    t.integer "holiday_delivery_method_id"
    t.integer "holiday_ship_on_day"
    t.integer "holiday_delivery_day_of_week"
    t.date "delivery_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["delivery_date"], name: "holiday_delivery_overrides_delivery_date"
    t.index ["menu_id"], name: "holiday_delivery_overrides_menu_id"
    t.index ["zip_codes_direct_line_id"], name: "holiday_delivery_overrides_zip_codes_direct_line_id"
  end

  create_table "holidays", id: :serial, force: :cascade do |t|
    t.date "date"
    t.string "description", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_holidays_on_date"
  end

  create_table "ingredients", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.boolean "paleo", default: false
    t.text "explanation"
    t.string "image", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients_taste_tags", id: :serial, force: :cascade do |t|
    t.integer "ingredient_id"
    t.integer "taste_tag_id"
    t.index ["ingredient_id"], name: "index_ingredients_taste_tags_on_ingredient_id"
    t.index ["taste_tag_id"], name: "index_ingredients_taste_tags_on_taste_tag_id"
  end

  create_table "invitations", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "invitee_id"
    t.string "invitee_email_address", limit: 255
    t.string "token", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["invitee_id"], name: "index_invitations_on_invitee_id"
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "jwt_blacklist", id: :serial, force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "kitchens", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.boolean "active"
    t.boolean "takes_new_users"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "packing_sheet_emails"
    t.text "shipstation_emails"
    t.text "cms_emails"
    t.text "report_emails"
    t.text "forecast_emails"
    t.text "meal_counts_emails"
  end

  create_table "lead_selected_addons", id: :serial, force: :cascade do |t|
    t.integer "lead_id"
    t.integer "menu_item_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lead_selected_meals", id: :serial, force: :cascade do |t|
    t.integer "lead_id", null: false
    t.integer "menu_item_id", null: false
    t.integer "quantity", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["lead_id"], name: "index_lead_selected_meals_on_lead_id"
    t.index ["menu_item_id"], name: "index_lead_selected_meals_on_menu_item_id"
  end

  create_table "leads", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, null: false
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "address_line_1", limit: 255
    t.string "address_line_2", limit: 255
    t.string "city", limit: 255
    t.string "state", limit: 255
    t.string "zip", limit: 255
    t.string "referral_source", limit: 255
    t.string "utm_source", limit: 255
    t.string "utm_medium", limit: 255
    t.string "utm_campaign", limit: 255
    t.string "ga_cookie", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "selected_plan_id"
    t.string "delivery_type", limit: 255
    t.text "delivery_instructions"
    t.string "stripe_token", limit: 255
    t.string "phone", limit: 255
    t.integer "user_id"
    t.string "coupon", limit: 255
    t.string "gift_card", limit: 255
    t.string "referral_code", limit: 255
    t.boolean "checkout_abandoned", default: false, null: false
    t.integer "signup_flow", default: 0, null: false
    t.string "stripe_customer_token", limit: 255
    t.string "page_referrer"
    t.string "gift_box_referral_code"
    t.string "unique_coupon"
    t.integer "brand"
    t.index "lower((email)::text)", name: "lead_lower_case_email"
    t.index ["email"], name: "index_leads_on_email"
  end

  create_table "line_items", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 1
    t.integer "order_id"
    t.integer "product_size_id"
    t.integer "price_in_pennies"
    t.string "currency", limit: 255, default: "USD"
    t.datetime "deleted_at"
    t.integer "meal_option_id"
    t.index ["cart_id"], name: "index_line_items_on_cart_id"
    t.index ["order_id"], name: "index_line_items_on_order_id"
    t.index ["product_id"], name: "index_line_items_on_product_id"
    t.index ["product_size_id"], name: "index_line_items_on_product_size_id"
  end

  create_table "line_items_addons", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "cart_id"
    t.integer "quantity", default: 1
    t.integer "order_id"
    t.integer "product_size_id"
    t.integer "price_in_pennies"
    t.string "currency", limit: 255, default: "USD"
    t.datetime "deleted_at"
    t.integer "meal_option_id"
    t.integer "basket_item_addon_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "cart_item_addon_id"
    t.integer "parent_id"
    t.string "parent_type"
    t.index ["order_id"], name: "line_items_addons_order_id"
  end

  create_table "meal_ingredients", id: :serial, force: :cascade do |t|
    t.integer "ingredient_id"
    t.integer "meal_option_id"
    t.integer "amount"
    t.string "unit", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["ingredient_id"], name: "index_meal_ingredients_on_ingredient_id"
    t.index ["meal_option_id"], name: "index_meal_ingredients_on_meal_option_id"
  end

  create_table "meal_options", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.string "name", limit: 255
    t.string "size", limit: 255
    t.integer "price_in_cents"
    t.text "ingredients"
    t.text "performance"
    t.text "description"
    t.integer "calories"
    t.integer "carbohydrates"
    t.integer "fat"
    t.integer "protein"
    t.integer "fiber"
    t.integer "sodium"
    t.integer "sugar"
    t.string "nutrition_image", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "old_product_size_id"
    t.datetime "deleted_at"
    t.integer "oz_protein"
    t.string "sauce_name", limit: 255
    t.string "sauce_nutrition_image", limit: 255
    t.index ["product_id"], name: "index_meal_options_on_product_id"
  end

  create_table "meal_options_taste_tags", id: :serial, force: :cascade do |t|
    t.integer "taste_tag_id"
    t.integer "meal_option_id"
    t.index ["meal_option_id"], name: "index_meal_options_taste_tags_on_meal_option_id"
    t.index ["taste_tag_id"], name: "index_meal_options_taste_tags_on_taste_tag_id"
  end

  create_table "meal_plan_status_histories", id: :serial, force: :cascade do |t|
    t.integer "active"
    t.integer "paused"
    t.integer "on_hold"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "active_to_process"
  end

  create_table "meal_plans", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "credit_card_id"
    t.integer "address_id"
    t.integer "delivery_day"
    t.boolean "automated_delivery", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "created_from_order"
    t.integer "num_weeks_to_skip", default: 0
    t.datetime "activated_at"
    t.datetime "canceled_at"
    t.integer "status"
    t.integer "coupon_id"
    t.boolean "should_randomize", default: true
    t.index ["status"], name: "index_meal_plans_on_status"
    t.index ["user_id"], name: "index_meal_plans_on_user_id"
  end

  create_table "meal_preferences", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "meal_tag_id"
    t.integer "preference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["meal_tag_id", "user_id"], name: "meal_tag_id_uniqueness", unique: true
    t.index ["meal_tag_id"], name: "index_meal_preferences_on_meal_tag_id"
    t.index ["user_id"], name: "index_meal_preferences_on_user_id"
  end

  create_table "meal_ratings", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "meal_option_id"
    t.datetime "deleted_at"
    t.integer "rating"
    t.text "primary_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "invalid_rating", default: false
    t.text "invalid_reason"
    t.integer "admin_user_id"
    t.index ["meal_option_id"], name: "meal_ratings_meal_option_id"
    t.index ["user_id"], name: "meal_ratings_user_id"
  end

  create_table "meal_replacement_files", id: :serial, force: :cascade do |t|
    t.string "attachment"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meal_tags", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "category", null: false
    t.integer "prefer_weight", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "exclude_weight", default: 0, null: false
    t.boolean "only_include", default: false, null: false
    t.integer "no_preference_weight", default: 0, null: false
    t.string "slug", limit: 255
    t.boolean "active", default: true
  end

  create_table "menu_items", id: :serial, force: :cascade do |t|
    t.integer "menu_id"
    t.integer "product_id"
    t.integer "row_order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "popular"
    t.boolean "recent"
    t.boolean "core"
    t.boolean "rotation"
    t.integer "sold_out_value"
    t.boolean "improved", default: false
    t.boolean "chef_special", default: false
    t.boolean "is_sold_out", default: false, null: false
    t.string "shipping_code"
  end

  create_table "menus", id: :serial, force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "title", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "active", default: false
  end

  create_table "nutrition_images", id: :serial, force: :cascade do |t|
    t.integer "meal_option_id"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "oauth_access_grants", id: :serial, force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.integer "application_id", null: false
    t.string "token", limit: 255, null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes", limit: 255
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", id: :serial, force: :cascade do |t|
    t.integer "resource_owner_id"
    t.integer "application_id"
    t.string "token", limit: 255, null: false
    t.string "refresh_token", limit: 255
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes", limit: 255
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "uid", limit: 255, null: false
    t.string "secret", limit: 255, null: false
    t.text "redirect_uri", null: false
    t.string "scopes", limit: 255, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "optimizely_experiments", id: :serial, force: :cascade do |t|
    t.string "route", limit: 255
    t.string "experiment_id", limit: 255
    t.boolean "active", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_auths", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "order_id"
    t.integer "credit_card_id", null: false
    t.string "stripe_id", limit: 255
    t.integer "total_authorized_in_cents", null: false
    t.integer "status", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["credit_card_id"], name: "index_order_auths_on_credit_card_id"
    t.index ["order_id"], name: "index_order_auths_on_order_id"
    t.index ["stripe_id"], name: "index_order_auths_on_stripe_id"
    t.index ["user_id"], name: "index_order_auths_on_user_id"
  end

  create_table "orders", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "address_street", limit: 255
    t.string "apartment", limit: 255
    t.string "state", limit: 255
    t.string "zip", limit: 255
    t.integer "total_in_pennies"
    t.text "food_instructions"
    t.text "delivery_instructions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "city", limit: 255
    t.date "delivery_date"
    t.string "referal_code", limit: 255
    t.string "phone", limit: 255
    t.string "coupon_codes", limit: 255
    t.integer "discount_in_pennies"
    t.integer "subtotal_in_pennies"
    t.bigint "tax_in_pennies"
    t.string "after_tax", limit: 255
    t.string "currency", limit: 255, default: "USD", null: false
    t.datetime "deleted_at"
    t.integer "item_subtotal_in_pennies"
    t.integer "shipping_and_handling_in_pennies"
    t.float "tax_rate"
    t.integer "coupon_id"
    t.string "coupon_name", limit: 255
    t.string "coupon_description", limit: 255
    t.integer "address_id"
    t.integer "credit_card_id"
    t.integer "factor_bucks_cents", default: 0
    t.integer "meal_plan_id"
    t.string "address_delivery_type", limit: 255
    t.string "shipping_type", limit: 255
    t.integer "infusionsoft_order_id"
    t.integer "infusionsoft_invoice_id"
    t.integer "status"
    t.integer "basket_id"
    t.string "tracking_number", limit: 255
    t.integer "delivery_method_id"
    t.text "packing_sheet_instruction"
    t.integer "addon_subtotal_in_pennies", default: 0
    t.integer "menu_id"
    t.string "avalara_transaction_id"
    t.string "avalara_transaction_code"
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["coupon_id"], name: "index_orders_on_coupon_id"
    t.index ["credit_card_id"], name: "index_orders_on_credit_card_id"
    t.index ["delivery_date"], name: "index_orders_on_delivery_date"
    t.index ["delivery_method_id"], name: "index_orders_on_delivery_method_id"
    t.index ["tracking_number"], name: "index_orders_on_tracking_number"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "orders_to_reports_audits", id: :serial, force: :cascade do |t|
    t.integer "order_id"
    t.integer "menu_id"
    t.string "delivery_report_filename"
    t.string "packing_sheet_report_filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_orders_to_reports_audits_on_menu_id"
    t.index ["order_id"], name: "index_orders_to_reports_audits_on_order_id"
  end

  create_table "orders_tracking_number_audits", id: :serial, force: :cascade do |t|
    t.integer "order_id"
    t.string "tracking_number"
    t.string "auditor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pack_purchases", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "package_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "credit_card_id"
    t.index ["package_id"], name: "index_pack_purchases_on_package_id"
    t.index ["user_id"], name: "index_pack_purchases_on_user_id"
  end

  create_table "package_groups", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "headline", limit: 255
    t.text "body_html"
    t.string "slug", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["slug"], name: "index_package_groups_on_slug"
  end

  create_table "packages", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.text "description"
    t.integer "price_in_cents"
    t.integer "factor_buck_credit_cents"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "offer_type", limit: 255
    t.string "slug", limit: 255
    t.integer "package_group_id"
    t.index ["package_group_id"], name: "index_packages_on_package_group_id"
    t.index ["slug"], name: "index_packages_on_slug"
  end

  create_table "plan_tiers", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.boolean "for_new_users"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "potential_customers", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255
    t.string "zip", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "delivery_in_zone"
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "source", limit: 255
  end

  create_table "pricing_grids", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_images", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.string "image", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["product_id"], name: "index_product_images_on_product_id"
  end

  create_table "product_meal_tags", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "meal_tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["meal_tag_id"], name: "index_product_meal_tags_on_meal_tag_id"
    t.index ["product_id"], name: "index_product_meal_tags_on_product_id"
  end

  create_table "product_sizes", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.string "name", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_in_pennies"
    t.string "currency", limit: 255, default: "USD"
    t.datetime "deleted_at"
    t.index ["id"], name: "index_product_sizes_on_id"
    t.index ["product_id"], name: "index_product_sizes_on_product_id"
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.text "menu_page_description"
    t.string "medium_calories", limit: 255
    t.string "large_calories", limit: 255
    t.string "medium_carbohydrates", limit: 255
    t.string "large_carbohydrates", limit: 255
    t.string "medium_fat", limit: 255
    t.string "large_fat", limit: 255
    t.string "medium_protein", limit: 255
    t.string "large_protein", limit: 255
    t.string "image", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "ingredients"
    t.string "meta_title", limit: 255
    t.text "meta_description"
    t.boolean "active"
    t.string "slug", limit: 255
    t.text "product_page_description"
    t.integer "batch_id"
    t.integer "row_order", default: 0
    t.string "nutrition_image", limit: 255
    t.integer "container"
    t.boolean "recent"
    t.boolean "popular"
    t.integer "num_items", default: 1
    t.datetime "active_start_date"
    t.datetime "active_end_date"
    t.integer "infusionsoft_product_id"
    t.decimal "meal_rating_average", precision: 6, scale: 4, default: "0.0"
    t.string "recipal_link"
    t.integer "addon_type_id"
    t.index ["batch_id"], name: "index_products_on_batch_id"
    t.index ["id"], name: "index_products_on_id"
    t.index ["slug"], name: "index_products_on_slug"
  end

  create_table "rebrand_product_images", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.string "image"
    t.integer "sort"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "referral_bonus", id: :serial, force: :cascade do |t|
    t.string "referral_type", limit: 255
    t.integer "amount_in_cents"
    t.integer "over_n_weeks", default: 1
  end

  create_table "referrals", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "code", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index "upper((code)::text)", name: "upper_code_referral"
    t.index ["code"], name: "index_referrals_on_code"
    t.index ["user_id"], name: "index_referrals_on_user_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "resource_id"
    t.string "resource_type", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "shipping_claims", id: :serial, force: :cascade do |t|
    t.integer "order_id"
    t.string "order_claim_type"
    t.string "courier"
    t.string "tracking_number"
    t.date "claim_date"
    t.string "customer_name"
    t.date "order_shipment_date"
    t.text "claim_reason"
    t.boolean "claim_submitted"
    t.boolean "refund_received"
    t.string "refund_amount"
    t.text "refund_notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shipping_costs", id: :serial, force: :cascade do |t|
    t.string "shipping_type", limit: 255
    t.integer "shipping_tier_id"
    t.integer "price_in_cents"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "delivery_method_id"
    t.index ["delivery_method_id"], name: "index_shipping_costs_on_delivery_method_id"
    t.index ["shipping_tier_id", "shipping_type"], name: "index_shipping_costs_on_shipping_tier_id_and_shipping_type", unique: true
  end

  create_table "shipping_tiers", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.boolean "for_new_users", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "signup_funnel_meals_experiment_users", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "group"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skipped_orders", id: :serial, force: :cascade do |t|
    t.integer "meal_plan_id"
    t.date "delivery_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json "properties", default: {}
    t.index ["meal_plan_id"], name: "index_skipped_orders_on_meal_plan_id"
  end

  create_table "slog_rows", id: :serial, force: :cascade do |t|
    t.text "message", null: false
    t.jsonb "log", default: {}, null: false
    t.jsonb "trace"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["log"], name: "index_slog_rows_on_log", using: :gin
    t.index ["message"], name: "index_slog_rows_on_message"
  end

  create_table "step_coupons", id: :serial, force: :cascade do |t|
    t.string "week_number"
    t.integer "discount_weightage"
    t.integer "coupon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coupon_id"], name: "index_step_coupons_on_coupon_id"
    t.index ["id"], name: "index_step_coupons_on_id"
  end

  create_table "subscription_histories", id: :serial, force: :cascade do |t|
    t.integer "subscription_id"
    t.string "user_action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscription_paused_dates", id: :serial, force: :cascade do |t|
    t.integer "subscription_id"
    t.datetime "pause_start_date"
    t.datetime "pause_end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["subscription_id"], name: "subscription_paused_dates_subscription_id"
  end

  create_table "subscription_processing_histories", id: :serial, force: :cascade do |t|
    t.string "started_by", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "basket_plan_id"
    t.integer "status"
    t.datetime "activated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "credit_card_id"
    t.integer "address_id"
    t.integer "taste_profile_id"
    t.boolean "checkout_abandoned"
    t.integer "lead_id"
    t.index ["lead_id"], name: "index_subscriptions_on_lead_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "taste_preferences", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "taste_tag_id"
    t.boolean "exclude", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "taste_profile_id"
    t.string "taste_tag_type", limit: 255
    t.index ["taste_profile_id"], name: "index_taste_preferences_on_taste_profile_id"
    t.index ["taste_tag_id"], name: "index_taste_preferences_on_taste_tag_id"
    t.index ["taste_tag_type"], name: "index_taste_preferences_on_taste_tag_type"
    t.index ["user_id"], name: "index_taste_preferences_on_user_id"
  end

  create_table "taste_profiles", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "num_dinners"
    t.string "meal_size", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "completed", default: false
    t.integer "num_lunches"
    t.integer "num_breakfasts"
    t.integer "num_snacks"
    t.integer "num_veggies"
    t.index ["user_id"], name: "index_taste_profiles_on_user_id"
  end

  create_table "taste_tags", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "row_order"
    t.string "help_text", limit: 255
    t.integer "tag_category"
  end

  create_table "testimonials", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.text "quote"
    t.string "from", limit: 255
    t.string "byline", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tracking_number_files", id: :serial, force: :cascade do |t|
    t.string "attachment"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", id: :serial, force: :cascade do |t|
    t.integer "order_id"
    t.integer "user_id"
    t.string "stripe_id", limit: 255
    t.integer "amount_in_pennies"
    t.boolean "success"
    t.string "charge_type", limit: 255
    t.text "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "order_type", limit: 255
    t.text "reason"
    t.string "refund_category", limit: 255
    t.integer "status"
    t.string "stripe_tokenization_method"
    t.integer "tax_in_pennies", default: 0
    t.integer "amount_no_tax_in_pennies", default: 0
    t.index ["order_id", "order_type"], name: "index_transactions_on_order_id_and_order_type"
    t.index ["stripe_id"], name: "index_transactions_on_stripe_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "unique_coupons", id: :serial, force: :cascade do |t|
    t.string "uuid"
    t.text "description"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.boolean "used", default: false
    t.integer "percent_off", default: 0
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_unique_coupons_on_email"
    t.index ["user_id"], name: "index_unique_coupons_on_user_id"
    t.index ["uuid"], name: "index_unique_coupons_on_uuid"
  end

  create_table "user_profiles", id: :serial, force: :cascade do |t|
    t.boolean "liked_or_disliked_meals", default: false
    t.boolean "purchased_package", default: false
    t.boolean "rate_meals", default: false
    t.boolean "refer_a_friend", default: false
    t.boolean "set_meal_preferences", default: false
    t.boolean "wrote_a_review", default: false
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "stripe_customer_token", limit: 255
    t.string "customer_id", limit: 255
    t.string "last_4_digits", limit: 255
    t.string "zip", limit: 255
    t.string "phone", limit: 255
    t.integer "referred_by_id"
    t.string "referral_source", limit: 255
    t.datetime "deleted_at"
    t.string "utm_source", limit: 255
    t.string "utm_medium", limit: 255
    t.string "utm_campaign", limit: 255
    t.string "ga_cookie", limit: 255
    t.integer "percent_off", default: 0
    t.boolean "free_delivery", default: false
    t.string "auth_token", limit: 255
    t.string "infusionsoft_id", limit: 255
    t.integer "state"
    t.integer "orders_count", default: 0
    t.integer "kitchen_id"
    t.boolean "eligible_for_free_delivery", default: false, null: false
    t.integer "plan_tier_id"
    t.boolean "extra_ice", default: false, null: false
    t.integer "shipping_tier_id"
    t.boolean "nutrition_consult_completed", default: false
    t.boolean "family_style_opt_in", default: false
    t.string "time_zone", limit: 255
    t.boolean "from_giftcard", default: false
    t.boolean "addons_opt_in", default: true
    t.boolean "soups_opt_in", default: false
    t.boolean "cold_press_juice_opt_in", default: true
    t.string "percent_off_admin"
    t.text "percent_off_reason"
    t.boolean "longpause_opt_in", default: true
    t.boolean "upgrade_box_size", default: false, null: false
    t.integer "gift_box_referred_by_id"
    t.boolean "fgb_share_feature", default: false
    t.integer "brand"
    t.index "lower((email)::text)", name: "user_lower_case_email"
    t.index ["customer_id"], name: "index_users_on_customer_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["gift_box_referred_by_id"], name: "index_users_on_gift_box_referred_by_id"
    t.index ["kitchen_id"], name: "index_users_on_kitchen_id"
    t.index ["referred_by_id"], name: "index_users_on_referred_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["state"], name: "index_users_on_state"
    t.index ["time_zone"], name: "index_users_on_time_zone"
  end

  create_table "users_delivery_method_overrides", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "delivery_method_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "service_code"
    t.integer "days_to_ship"
    t.integer "delivery_day_of_week"
    t.integer "zip_codes_direct_line_id"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "version_associations", id: :serial, force: :cascade do |t|
    t.integer "version_id"
    t.string "foreign_key_name", limit: 255, null: false
    t.integer "foreign_key_id"
    t.index ["foreign_key_name", "foreign_key_id"], name: "index_version_associations_on_foreign_key"
    t.index ["version_id"], name: "index_version_associations_on_version_id"
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.string "item_type", limit: 255, null: false
    t.integer "item_id", null: false
    t.string "event", limit: 255, null: false
    t.string "whodunnit", limit: 255
    t.text "object"
    t.datetime "created_at"
    t.integer "transaction_id"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["transaction_id"], name: "index_versions_on_transaction_id"
  end

  create_table "vip_domains", id: :serial, force: :cascade do |t|
    t.string "domain", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vip_leads", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "email", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zip_codes", id: :serial, force: :cascade do |t|
    t.string "zip_code", limit: 255
    t.string "city", limit: 255
    t.string "state", limit: 255
    t.string "county", limit: 255
    t.integer "population"
    t.integer "delivery_surcharge_in_pennies"
    t.float "tax_pct"
    t.text "notes"
    t.boolean "monday_del", default: false
    t.boolean "tuesday_del", default: false
    t.boolean "wednesday_del", default: false
    t.boolean "thursday_del", default: false
    t.boolean "friday_del", default: false
    t.boolean "saturday_del", default: false
    t.boolean "sunday_del", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "delivery_cost_in_pennies"
    t.string "shipping_option", limit: 255
    t.integer "delivery_method_id"
    t.index ["delivery_method_id"], name: "index_zip_codes_on_delivery_method_id"
    t.index ["zip_code"], name: "index_zip_codes_on_zip_code"
  end

  create_table "zip_codes_delivery_method_options", id: :serial, force: :cascade do |t|
    t.string "zip_code", limit: 255
    t.integer "delivery_method_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "zip_codes_direct_line_id"
    t.integer "days_to_ship"
    t.integer "delivery_day_of_week"
  end

  create_table "zip_codes_direct_line_maps", id: :serial, force: :cascade do |t|
    t.string "mapped_zip_code"
    t.integer "zip_codes_direct_line_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mapped_zip_code"], name: "index_zip_codes_direct_line_maps_on_mapped_zip_code"
    t.index ["zip_codes_direct_line_id"], name: "index_zip_codes_direct_line_maps_on_zip_codes_direct_line_id"
  end

  create_table "zip_codes_direct_lines", id: :serial, force: :cascade do |t|
    t.string "courier"
    t.string "DL_city"
    t.string "DL_state"
    t.integer "delivery_method_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kitchen_id"
    t.index ["delivery_method_id"], name: "index_zip_codes_direct_lines_on_delivery_method_id"
  end

  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id", name: "oauth_access_grants_resource_owner_id_fk"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id", name: "oauth_access_tokens_resource_owner_id_fk"
  add_foreign_key "orders_tracking_number_audits", "orders", on_delete: :cascade
end
