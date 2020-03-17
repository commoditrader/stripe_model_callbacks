class RenameApplicationFeeToApplicationFeeAmountOfStripeInvoices < ActiveRecord::Migration[5.2]
  def change
    rename_column :stripe_invoices, :application_fee_cents, :application_fee_amount_cents
    rename_column :stripe_invoices, :application_fee_currency, :application_fee_amount_currency
  end
end
