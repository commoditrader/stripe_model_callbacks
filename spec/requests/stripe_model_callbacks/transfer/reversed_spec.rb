require "rails_helper"

describe "transfer reversed" do
  let!(:transfer) { create :stripe_transfer, id: "tr_00000000000000" }

  describe "#execute!" do
    it "logs an activity and updates the transfer" do
      expect { PublicActivity.with_tracking { mock_stripe_event("transfer.reversed") } }
        .to change(StripeTransfer, :count).by(0)
        .and change(PublicActivity::Activity.where(key: "stripe_transfer.reversed"), :count).by(1)

      transfer.reload

      expect(response.code).to eq "200"

      expect(transfer.id).to eq "tr_00000000000000"
      expect(transfer.amount.format).to eq "$11.00"
      expect(transfer.amount_reversed.format).to eq "$0.00"
      expect(transfer.balance_transaction).to eq "txn_00000000000000"
      expect(transfer.created).to eq Time.zone.parse("2018-02-06 08:54:49")
      expect(transfer.currency).to eq "usd"
      expect(transfer.description).to eq nil
      expect(transfer.destination).to eq "acct_1Brq15AT5SYrvIfd"
      expect(transfer.destination_payment).to eq "py_CH0EOf6bFQq9g2"
      expect(transfer.livemode).to eq false
      expect(transfer.metadata).to eq "{}"
      expect(transfer.reversed?).to eq false
      expect(transfer.source_transaction).to eq nil
      expect(transfer.source_type).to eq "card"
      expect(transfer.transfer_group).to eq nil
    end
  end
end
