FactoryBot.define do
  factory :stripe_subscription, class: StripeModelCallbacks::StripeSubscription do
    sequence(:identifier) { |n| "stripe-subscription-#{n}" }
    billing "charge_automatically"
    cancel_at_period_end false
    current_period_start Time.zone.now.beginning_of_month
    current_period_end Time.zone.now.end_of_month
    association :customer, factory: :stripe_customer
    livemode false
    association :plan, factory: :stripe_plan
    start 1.month.ago.beginning_of_month
  end
end
