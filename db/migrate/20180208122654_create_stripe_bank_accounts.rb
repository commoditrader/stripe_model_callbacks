class CreateStripeBankAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :stripe_bank_accounts, id: false do |t|
      t.string :id, primary: true, null: false
      t.string :stripe_account_id, index: true
      t.string :account_holder_name
      t.string :account_holder_type
      t.string :bank_name
      t.string :country
      t.string :currency
      t.boolean :default_for_currency
      t.string :fingerprint
      t.string :last4
      t.text :metadata
      t.string :routing_number
      t.string :status, index: true
      t.timestamps
    end
  end
end
