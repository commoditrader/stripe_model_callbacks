# This migration comes from stripe_model_callbacks (originally 20201224122058)
class CreateStripePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :stripe_prices do |t|
      t.string :stripe_id, index: true, null: false
      t.datetime :deleted_at
      t.boolean :active
      t.string :billing_scheme
      t.datetime :created
      t.string :currency
      t.string :lookup_key
      t.json :metadata
      t.string :nickname
      t.string :stripe_product_id, index: true
      t.boolean :recurring_aggregate_usage
      t.string :recurring_interval
      t.integer :recurring_interval_count
      t.string :recurring_usage_type
      t.string :tiers_mode
      t.integer :transform_quantity_divide_by
      t.string :transform_quantity_round
      t.string :price_type
      t.integer :unit_amount
      t.timestamps
    end
  end
end
