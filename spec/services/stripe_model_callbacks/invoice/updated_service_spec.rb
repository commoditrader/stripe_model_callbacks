require "rails_helper"

describe StripeModelCallbacks::Invoice::UpdatedService do
  subject(:updated_service) { described_class.execute!(event: stripe_event) }

  let(:stripe_event) { Stripe::Event.construct_from(event_values) }
  let(:event_payload) { File.read("spec/fixtures/stripe/invoice/created.json") }
  let(:event_values) do
    {
      id: "evt_charge_succeeded",
      type: event_type,
      data: JSON.parse(event_payload, symbolize_names: true)
    }
  end

  context "when 'invoice.created' event was sent" do
    let(:event_type) { "invoice.created" }

    context "when invoice don't exist" do
      it "creates stripe invoice" do
        expect { updated_service }.to change { StripeInvoice.all.size }.by(1)
      end
    end

    context "when invoice already exist" do
      let!(:stripe_invoice) { create(:stripe_invoice, stripe_id: "in_1GiGbYGJAmuZ9ZZZmstXLFQx") }

      it "does not create new stripe invoice" do
        expect { updated_service }.not_to change(StripeInvoice.all, :size)
      end
    end
  end

  context "when 'invoice.payment_succeeded' event was sent" do
    let(:event_type) { "invoice.payment_succeeded" }

    context "when invoice don't exist" do
      it "creates stripe invoice" do
        expect { updated_service }.to change { StripeInvoice.all.size }.by(1)
      end

      it "creates stripe invoice activity" do
        updated_service
        expect(PublicActivity::Activity.last.key).to eq("stripe_invoice.payment_succeeded")
      end
    end

    context "when invoice already exist" do
      let!(:stripe_invoice) { create(:stripe_invoice, stripe_id: "in_1GiGbYGJAmuZ9ZZZmstXLFQx") }

      it "does not create new stripe invoice" do
        expect { updated_service }.not_to change(StripeInvoice.all, :size)
      end
    end
  end
end
