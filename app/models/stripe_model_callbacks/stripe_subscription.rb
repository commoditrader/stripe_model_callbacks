class StripeModelCallbacks::StripeSubscription < StripeModelCallbacks::ApplicationRecord
  self.table_name = "stripe_subscriptions"

  belongs_to :customer,
    class_name: "StripeModelCallbacks::StripeCustomer",
    foreign_key: "customer_identifier",
    optional: true,
    primary_key: "identifier"

  belongs_to :discount,
    class_name: "StripeModelCallbacks::StripeDiscount",
    foreign_key: "discount_identifier",
    optional: true,
    primary_key: "identifier"

  belongs_to :plan,
    class_name: "StripeModelCallbacks::StripePlan",
    foreign_key: "plan_identifier",
    optional: true,
    primary_key: "identifier"

  has_many :invoices,
    class_name: "StripeModelCallbacks::StripeInvoice",
    foreign_key: "subscription_identifier",
    primary_key: "identifier"

  def assign_from_stripe(object)
    assign_attributes(
      billing: object.billing,
      created_at: Time.zone.at(object.created),
      canceled_at: object.canceled_at ? Time.zone.at(object.canceled_at) : nil,
      cancel_at_period_end: object.cancel_at_period_end,
      current_period_start: Time.zone.at(object.current_period_start),
      current_period_end: Time.zone.at(object.current_period_end),
      customer_identifier: object.customer,
      ended_at: object.ended_at ? Time.zone.at(object.ended_at) : nil,
      identifier: object.id,
      livemode: object.livemode,
      plan_identifier: object.plan.id,
      start: Time.zone.at(object.start),
      trial_start: object.trial_start ? Time.zone.at(object.trial_start) : nil,
      trial_end: object.trial_end ? Time.zone.at(object.trial_end) : nil
    )
  end
end
