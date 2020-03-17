class CreateStripeSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :stripe_subscriptions do |t|
      t.string :stripe_id, index: true, null: false
      t.integer :application_fee_percent
      t.string :billing
      t.boolean :cancel_at_period_end
      t.datetime :canceled_at
      t.datetime :current_period_start
      t.datetime :current_period_end
      t.string :stripe_customer_id, index: true
      t.integer :days_until_due
      t.string :discount, index: true
      t.datetime :ended_at
      t.boolean :livemode, default: true
      t.text :metadata
      t.string :stripe_plan_id, index: true
      t.integer :quantity
      t.datetime :start_date
      t.integer :tax_percent
      t.string :status, index: true
      t.datetime :trial_start
      t.datetime :trial_end
      t.datetime :deleted_at, index: true
      t.datetime :created
      t.timestamps
    end
  end
end
