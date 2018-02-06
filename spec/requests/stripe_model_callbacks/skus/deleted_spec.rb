require "rails_helper"

describe "sku deleted" do
  let!(:sku) { create :stripe_sku, identifier: "sku_00000000000000" }

  def bypass_event_signature(payload)
    event = Stripe::Event.construct_from(JSON.parse(payload, symbolize_names: true))
    expect(Stripe::Webhook).to receive(:construct_event).and_return(event)
  end

  let(:payload) { File.read("spec/fixtures/stripe_events/sku/sku.deleted.json") }
  before { bypass_event_signature(payload) }

  describe "#execute!" do
    it "creates the subscription" do
      expect { post "/stripe-events", params: payload }
        .to change(StripeSku, :count).by(0)

      sku.reload

      expect(response.code).to eq "200"

      expect(sku.identifier).to eq "sku_00000000000000"
      expect(sku.inventory_quantity).to eq 50
      expect(sku.inventory_type).to eq "finite"
      expect(sku.inventory_value).to eq nil
      expect(sku.livemode).to eq false
      expect(sku.metadata).to eq "{}"
      expect(sku.price.format).to eq "$15.00"
      expect(sku.product_identifier).to eq "prod_00000000000000"
      expect(sku.deleted_at).to be > 1.minute.ago
    end
  end
end
