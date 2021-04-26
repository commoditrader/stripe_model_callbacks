class StripeInvoiceItem < StripeModelCallbacks::ApplicationRecord
  belongs_to :stripe_customer, optional: true, primary_key: "stripe_id"
  belongs_to :stripe_invoice, optional: true, primary_key: "stripe_id"
  belongs_to :stripe_subscription, optional: true, primary_key: "stripe_id"
  belongs_to :stripe_subscription_item, optional: true, primary_key: "stripe_id"
  belongs_to :stripe_plan, optional: true, primary_key: "stripe_id"

  monetize :amount_cents

  def self.stripe_class
    Stripe::InvoiceItem
  end

  def assign_from_stripe(object)
    check_object_is_stripe_class(object, [Stripe::InvoiceItem, Stripe::InvoiceLineItem])
    assign_attributes(
      amount: Money.new(object.amount, object.currency),
      stripe_customer_id: object.try(:customer),
      metadata: JSON.generate(object.metadata),
      period_start: Time.zone.at(object.period.start),
      period_end: Time.zone.at(object.period.end),
      stripe_plan_id: object.plan&.id,
      stripe_subscription_id: object.subscription
    )

    self.stripe_subscription_item_id = object.subscription_item if object.respond_to?(:subscription_item)

    StripeModelCallbacks::AttributesAssignerService.execute!(
      model: self, stripe_model: object,
      attributes: %w[
        currency description discountable id livemode proration quantity
      ]
    )
  end
end
