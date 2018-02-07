class StripeDiscount < StripeModelCallbacks::ApplicationRecord
  self.primary_key = "id"

  belongs_to :stripe_coupon, optional: true
  belongs_to :stripe_customer, optional: true
  belongs_to :stripe_subscription, optional: true
  has_many :stripe_subscriptions

  monetize :coupon_amount_off_cents, allow_nil: true

  def self.stripe_class
    Stripe::Discount
  end

  def assign_from_stripe(object)
    assign_attributes(
      created: object.respond_to?(:created) ? Time.zone.at(object.created) : nil,
      start: Time.zone.at(object.start),
      end: Time.zone.at(object.end),
      stripe_customer_id: object.customer,
      stripe_subscription_id: object.subscription&.id
    )

    assign_coupon_attributes(object)
    assign_other_coupon_attributes(object)
  end

private

  def assign_coupon_attributes(object)
    assign_attributes(
      coupon_amount_off_cents: object.coupon.amount_off ? Money.new(object.coupon.amount_off, object.coupon.currency) : nil,
      coupon_created: Time.zone.at(object.coupon.created),
      coupon_currency: object.coupon.currency,
      coupon_duration: object.coupon.duration,
      coupon_duration_in_months: object.coupon.duration_in_months,
      coupon_livemode: object.coupon.livemode
    )
  end

  def assign_other_coupon_attributes(object)
    assign_attributes(
      coupon_max_redemptions: object.coupon.max_redemptions,
      coupon_metadata: JSON.generate(object.coupon.metadata),
      coupon_percent_off: object.coupon.percent_off,
      coupon_redeem_by: object.coupon.redeem_by ? Time.zone.at(object.coupon.redeem_by) : nil,
      coupon_times_redeemed: object.coupon.times_redeemed,
      coupon_valid: object.coupon.valid
    )
  end
end