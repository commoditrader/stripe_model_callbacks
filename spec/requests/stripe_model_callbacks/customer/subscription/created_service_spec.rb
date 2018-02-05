require "rails_helper"

describe StripeModelCallbacks::Customer::Subscription::CreatedService do
  let!(:stripe_account) { create :stripe_account, stripe_customer_identifier: "cus_00000000000000" }
  let!(:stripe_plan) { create :stripe_plan, stripe_identifier: "silver-express-898_00000000000000" }

  def bypass_event_signature(payload)
    event = Stripe::Event.construct_from(JSON.parse(payload, symbolize_names: true))
    expect(Stripe::Webhook).to receive(:construct_event).and_return(event)
  end

  let(:payload) { File.read(Rails.root.join("spec", "fixtures", "stripe_events", "customer_subscription_created.json")) }
  before { bypass_event_signature(payload) }

  describe "#execute!" do
    it "creates the subscription" do
      expect { post "/stripe-events", params: payload }
        .to change(Subscription, :count).by(1)

      created_subscription = StripeModelCallbacks::StripeCustomerSubscription.last

      expect(response.code).to eq "200"
      expect(created_subscription.account).to eq stripe_account
      expect(created_subscription.plan).to eq stripe_plan
      expect(created_subscription.state).to eq "active"
    end
  end
end
