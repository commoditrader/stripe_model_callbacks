class StripeCoupon < StripeModelCallbacks::ApplicationRecord
  self.primary_key = "id"

  monetize :amount_off_cents, allow_nil: true

  has_many :stripe_discounts,
    class_name: "StripeDiscount",
    dependent: :restrict_with_error,
    inverse_of: :stripe_coupon

  def assign_from_stripe(object)
    assign_attributes(
      amount_off: object.amount_off ? Money.new(object.amount_off, object.currency) : nil,
      created: Time.zone.at(object.created),
      metadata: JSON.generate(object.metadata),
      stripe_valid: object.valid
    )

    StripeModelCallbacks::AttributesAssignerService.execute!(
      model: self, stripe_model: object,
      attributes: %w[
        currency duration duration_in_months livemode max_redemptions percent_off redeem_by
        times_redeemed
      ]
    )
  end
end
