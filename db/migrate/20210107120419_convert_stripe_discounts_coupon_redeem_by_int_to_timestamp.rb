class ConvertStripeDiscountsCouponRedeemByIntToTimestamp < ActiveRecord::Migration[6.0]
  def up
    StripeDiscount.where.not(coupon_redeem_by_int: nil).each do |stripe_discount|
      stripe_discount.update_columns(coupon_redeem_by: Time.zone.at(stripe_discount.coupon_redeem_by_int)) # rubocop:disable Rails/SkipsModelValidations
    end

    remove_colum :stripe_discounts, :coupon_redeem_by_int
  end

  def down
    add_colum :stripe_discounts, :coupon_redeem_by_int

    StripeDiscount.where.not(coupon_redeem_by: nil).each do |stripe_discount|
      stripe_discount.update_columns(coupon_redeem_by_int: stripe_discount.coupon_redeem_by.to_i) # rubocop:disable Rails/SkipsModelValidations
    end
  end
end
