class StripeSubscriptionItem < StripeModelCallbacks::ApplicationRecord
  self.primary_key = "id"

  belongs_to :stripe_plan, optional: true
  belongs_to :stripe_subscription, optional: true

  def self.stripe_class
    Stripe::SubscriptionItem
  end

  def assign_from_stripe(object)
    self.stripe_subscription_id = object.subscription if object.respond_to?(:subscription)
    self.stripe_plan_id = object.plan.id if object.plan.respond_to?(:id)

    StripeModelCallbacks::AttributesAssignerService.execute!(
      model: self, stripe_model: object,
      attributes: %w[id created metadata quantity]
    )
  end
end
