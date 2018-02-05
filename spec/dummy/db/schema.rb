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

ActiveRecord::Schema.define(version: 20180205214861) do

  create_table "activities", force: :cascade do |t|
    t.string "trackable_type"
    t.integer "trackable_id"
    t.string "owner_type"
    t.integer "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner_type_and_owner_id"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient_type_and_recipient_id"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id"
  end

  create_table "stripe_charges", force: :cascade do |t|
    t.string "identifier", null: false
    t.integer "amount_cents", null: false
    t.string "amount_currency", null: false
    t.integer "amount_refunded_cents"
    t.string "amount_refunded_currency"
    t.integer "application_cents"
    t.string "application_currency"
    t.string "currency", null: false
    t.boolean "captured", null: false
    t.boolean "paid", null: false
    t.string "dispute"
    t.string "failure_code"
    t.string "failure_message"
    t.text "fraud_details"
    t.text "outcome"
    t.boolean "refunded", null: false
    t.string "review"
    t.string "description"
    t.string "customer_identifier"
    t.string "order_identifier"
    t.string "source_identifier"
    t.string "invoice_identifier"
    t.string "on_behalf_of"
    t.string "receipt_email"
    t.string "receipt_number"
    t.text "shipping"
    t.boolean "livemode", null: false
    t.text "metadata"
    t.string "source_transfer"
    t.string "statement_descriptor"
    t.string "status"
    t.string "transfer_group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_identifier"], name: "index_stripe_charges_on_customer_identifier"
    t.index ["identifier"], name: "index_stripe_charges_on_identifier"
    t.index ["invoice_identifier"], name: "index_stripe_charges_on_invoice_identifier"
    t.index ["order_identifier"], name: "index_stripe_charges_on_order_identifier"
    t.index ["source_identifier"], name: "index_stripe_charges_on_source_identifier"
  end

  create_table "stripe_customers", force: :cascade do |t|
    t.string "identifier", null: false
    t.integer "account_balance", null: false
    t.string "business_vat_id"
    t.datetime "deleted_at"
    t.string "currency"
    t.string "default_source"
    t.boolean "delinquent", null: false
    t.string "description"
    t.text "discount"
    t.string "email"
    t.boolean "livemode", null: false
    t.text "metadata"
    t.text "shipping"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_stripe_customers_on_deleted_at"
    t.index ["identifier"], name: "index_stripe_customers_on_identifier"
  end

  create_table "stripe_discounts", force: :cascade do |t|
    t.string "identifier", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_stripe_discounts_on_identifier"
  end

  create_table "stripe_invoice_items", force: :cascade do |t|
    t.string "identifier", null: false
    t.integer "amount_cents"
    t.string "amount_currency"
    t.string "customer_identifier"
    t.string "currency", null: false
    t.date "datetime"
    t.datetime "deleted_at"
    t.string "description"
    t.boolean "discountable", null: false
    t.string "invoice_identifier"
    t.boolean "livemode", null: false
    t.text "metadata"
    t.datetime "period_start"
    t.datetime "period_end"
    t.string "plan_identifier"
    t.boolean "proration", null: false
    t.integer "quantity"
    t.string "subscription_identifier"
    t.string "subscription_item"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_identifier"], name: "index_stripe_invoice_items_on_customer_identifier"
    t.index ["deleted_at"], name: "index_stripe_invoice_items_on_deleted_at"
    t.index ["identifier"], name: "index_stripe_invoice_items_on_identifier"
    t.index ["invoice_identifier"], name: "index_stripe_invoice_items_on_invoice_identifier"
    t.index ["plan_identifier"], name: "index_stripe_invoice_items_on_plan_identifier"
    t.index ["subscription_identifier"], name: "index_stripe_invoice_items_on_subscription_identifier"
  end

  create_table "stripe_invoices", force: :cascade do |t|
    t.string "identifier", null: false
    t.integer "amount_due_cents", null: false
    t.string "amount_due_currency", null: false
    t.integer "application_fee_cents"
    t.string "application_fee_currency"
    t.string "billing", null: false
    t.integer "discount_cents"
    t.string "discount_currency"
    t.integer "ending_balance_cents"
    t.integer "ending_balance_currency"
    t.string "charge_identifier"
    t.string "currency", null: false
    t.integer "subtotal_cents"
    t.string "subtotal_currency"
    t.integer "tax_cents"
    t.string "tax_currency"
    t.decimal "tax_percent"
    t.integer "total_cents"
    t.string "total_currency"
    t.string "customer_identifier", null: false
    t.string "description"
    t.boolean "forgiven", null: false
    t.string "receipt_number"
    t.string "subscription_identifier"
    t.boolean "attempted", null: false
    t.datetime "next_payment_attempt"
    t.boolean "closed", null: false
    t.datetime "date", null: false
    t.datetime "due_date"
    t.boolean "livemode", null: false
    t.text "metadata"
    t.string "number"
    t.boolean "paid", null: false
    t.datetime "period_start"
    t.datetime "period_end"
    t.integer "starting_balance_cents"
    t.string "starting_balance_currency"
    t.string "statement_descriptor"
    t.datetime "subscription_proration_date"
    t.datetime "webhooks_delivered_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["charge_identifier"], name: "index_stripe_invoices_on_charge_identifier"
    t.index ["customer_identifier"], name: "index_stripe_invoices_on_customer_identifier"
    t.index ["identifier"], name: "index_stripe_invoices_on_identifier"
    t.index ["subscription_identifier"], name: "index_stripe_invoices_on_subscription_identifier"
  end

  create_table "stripe_order_items", force: :cascade do |t|
    t.string "parent_identifier", null: false
    t.string "order_identifier", null: false
    t.integer "amount_cents", null: false
    t.string "amount_currency", null: false
    t.string "currency", null: false
    t.string "description"
    t.integer "quantity"
    t.string "order_item_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_identifier"], name: "index_stripe_order_items_on_order_identifier"
    t.index ["parent_identifier"], name: "index_stripe_order_items_on_parent_identifier"
  end

  create_table "stripe_orders", force: :cascade do |t|
    t.string "identifier", null: false
    t.integer "amount_cents", null: false
    t.string "amount_currency", null: false
    t.integer "amount_returned_cents"
    t.string "amount_returned_currency"
    t.integer "application_cents"
    t.string "application_currency"
    t.integer "application_fee"
    t.string "charge_identifier"
    t.string "currency", null: false
    t.string "customer_identifier"
    t.string "email"
    t.boolean "livemode", null: false
    t.text "metadata"
    t.string "selected_shipping_method"
    t.string "shipping_address_city"
    t.string "shipping_address_country"
    t.string "shipping_address_line1"
    t.string "shipping_address_line2"
    t.string "shipping_address_postal_code"
    t.string "shipping_address_state"
    t.string "shipping_carrier"
    t.string "shipping_name"
    t.string "shipping_phone"
    t.string "shipping_tracking_number"
    t.string "shipping_methods"
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["charge_identifier"], name: "index_stripe_orders_on_charge_identifier"
    t.index ["customer_identifier"], name: "index_stripe_orders_on_customer_identifier"
    t.index ["identifier"], name: "index_stripe_orders_on_identifier"
  end

  create_table "stripe_plans", force: :cascade do |t|
    t.string "identifier", null: false
    t.integer "amount_cents", null: false
    t.string "amount_currency", null: false
    t.string "currency", null: false
    t.string "interval", null: false
    t.integer "interval_count", null: false
    t.boolean "livemode", null: false
    t.text "metadata"
    t.string "name", null: false
    t.string "statement_descriptor"
    t.integer "trial_period_days"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_stripe_plans_on_deleted_at"
    t.index ["identifier"], name: "index_stripe_plans_on_identifier"
  end

  create_table "stripe_products", force: :cascade do |t|
    t.string "identifier", null: false
    t.boolean "active", default: false, null: false
    t.datetime "deleted_at"
    t.text "stripe_attributes"
    t.string "caption"
    t.string "description"
    t.boolean "livemode", default: false, null: false
    t.text "metadata"
    t.string "name"
    t.decimal "package_dimensions_height"
    t.decimal "package_dimensions_length"
    t.decimal "package_dimensions_weight"
    t.decimal "package_dimensions_width"
    t.boolean "shippable", default: false, null: false
    t.string "statement_descriptor"
    t.text "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_stripe_products_on_deleted_at"
    t.index ["identifier"], name: "index_stripe_products_on_identifier"
  end

  create_table "stripe_recipients", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "active_account"
    t.string "description"
    t.datetime "deleted_at"
    t.string "name"
    t.string "email"
    t.boolean "livemode", default: false, null: false
    t.string "stripe_type"
    t.text "metadata"
    t.string "migrated_to"
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_stripe_recipients_on_deleted_at"
    t.index ["identifier"], name: "index_stripe_recipients_on_identifier"
  end

  create_table "stripe_refunds", force: :cascade do |t|
    t.string "identifier", null: false
    t.integer "amount_cents"
    t.string "amount_currency"
    t.string "balance_transaction"
    t.string "charge_identifier", null: false
    t.string "currency", null: false
    t.string "failure_balance_transaction"
    t.string "failure_reason"
    t.boolean "livemode", null: false
    t.text "metadata"
    t.string "reason"
    t.string "receipt_number"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_stripe_refunds_on_identifier"
  end

  create_table "stripe_skus", force: :cascade do |t|
    t.string "identifier", null: false
    t.boolean "active", default: false, null: false
    t.datetime "deleted_at"
    t.text "stripe_attributes"
    t.string "currency", null: false
    t.integer "inventory_quantity"
    t.string "inventory_type"
    t.string "inventory_value"
    t.boolean "livemode"
    t.text "metadata"
    t.integer "price_cents"
    t.string "price_currency"
    t.string "product_identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_stripe_skus_on_deleted_at"
    t.index ["identifier"], name: "index_stripe_skus_on_identifier"
    t.index ["product_identifier"], name: "index_stripe_skus_on_product_identifier"
  end

  create_table "stripe_sources", force: :cascade do |t|
    t.string "identifier", null: false
    t.integer "amount_cents"
    t.string "amount_currency"
    t.string "client_secret", null: false
    t.string "currency"
    t.string "flow", null: false
    t.boolean "livemode", null: false
    t.string "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_stripe_sources_on_identifier"
  end

  create_table "stripe_subscriptions", force: :cascade do |t|
    t.string "identifier", null: false
    t.integer "application_fee_percent"
    t.string "billing", null: false
    t.boolean "cancel_at_period_end", null: false
    t.datetime "canceled_at"
    t.datetime "current_period_start", null: false
    t.datetime "current_period_end", null: false
    t.string "customer_identifier", null: false
    t.integer "days_until_due"
    t.string "discount"
    t.datetime "ended_at"
    t.boolean "livemode", null: false
    t.text "metadata"
    t.string "plan_identifier", null: false
    t.integer "quantity"
    t.datetime "start", null: false
    t.integer "tex_percent"
    t.datetime "trial_start"
    t.datetime "trial_end"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_identifier"], name: "index_stripe_subscriptions_on_customer_identifier"
    t.index ["deleted_at"], name: "index_stripe_subscriptions_on_deleted_at"
    t.index ["discount"], name: "index_stripe_subscriptions_on_discount"
    t.index ["identifier"], name: "index_stripe_subscriptions_on_identifier"
    t.index ["plan_identifier"], name: "index_stripe_subscriptions_on_plan_identifier"
  end

end
