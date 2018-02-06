class CreateStripePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :stripe_plans, id: false do |t|
      t.string :id, primary: true, null: false
      t.integer :amount_cents, null: false
      t.string :amount_currency, null: false
      t.string :currency, null: false
      t.string :interval, null: false
      t.integer :interval_count, null: false
      t.boolean :livemode, null: false
      t.text :metadata
      t.string :name, null: false
      t.string :statement_descriptor
      t.integer :trial_period_days
      t.datetime :deleted_at, index: true
      t.datetime :created
      t.timestamps
    end
  end
end
