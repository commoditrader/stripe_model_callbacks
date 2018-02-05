FactoryBot.define do
  factory :stripe_customer, class: StripeModelCallbacks::StripeCustomer do
    sequence(:identifier) { |n| "customer-identifier-#{n}" }
    account_balance 0
    currency "usd"
    delinquent false
    livemode false
  end
end
