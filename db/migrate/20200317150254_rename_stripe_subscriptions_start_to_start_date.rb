class RenameStripeSubscriptionsStartToStartDate < ActiveRecord::Migration[5.2]
  def change
    rename_column :stripe_subscriptions, :start, :start_date
  end
end
