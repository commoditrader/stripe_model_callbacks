class RenameStripeInvoicesDateToCreated < ActiveRecord::Migration[6.0]
  def change
    rename_column :stripe_invoices, :date, :created
  end
end
