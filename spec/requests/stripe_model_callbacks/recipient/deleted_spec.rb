require "rails_helper"

describe "recipient created" do
  let!(:recipient) { create :stripe_recipient, id: "rp_00000000000000" }

  describe "#execute!" do
    it "deletes the recipient" do
      expect { mock_stripe_event("recipient.deleted") }
        .to change(StripeRecipient, :count).by(0)

      recipient.reload

      expect(response.code).to eq "200"

      expect(recipient.id).to eq "rp_00000000000000"
      expect(recipient.description).to eq "Recipient for John Doe"
      expect(recipient.email).to eq "test@example.com"
      expect(recipient.name).to eq "John Doe"
      expect(recipient.stripe_type).to eq "individual"
      expect(recipient.deleted_at).to be > 1.minute.ago
    end
  end
end
