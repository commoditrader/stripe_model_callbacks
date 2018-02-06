class CreateStripeTransfers < ActiveRecord::Migration[5.0]
  def change
    create_table :stripe_transfers, id: false do |t|
      t.string :id, primary: true, null: false
      t.integer :amount_cents, null: false
      t.string :amount_currency, null: false
      t.integer :amount_reversed_cents, null: false
      t.string :amount_reversed_currency, null: false
      t.string :balance_transaction
      t.datetime :created
      t.string :currency, null: false
      t.string :description
      t.string :destination
      t.string :destination_payment
      t.boolean :livemode, default: false, null: false
      t.text :metadata
      t.boolean :reversed, default: false, null: false
      t.string :source_transaction
      t.string :source_type
      t.string :transfer_group
      t.string :status
      t.timestamps
    end
  end
end
