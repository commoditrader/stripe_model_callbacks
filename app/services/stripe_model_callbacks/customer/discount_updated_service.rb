class StripeModelCallbacks::Customer::DiscountUpdatedService < StripeModelCallbacks::BaseEventService
  def execute!
    discount.assign_from_stripe(object)
    discount.deleted_at ||= Time.zone.now if event.type == "customer.discount.deleted"

    if discount.save
      create_activity
      ServicePattern::Response.new(success: true)
    else
      ServicePattern::Response.new(errors: discount.errors.full_messages)
    end
  end

private

  def create_activity
    discount.create_activity :deleted if event.type == "customer.discount.deleted"
  end

  def discount
    @_discount ||= StripeDiscount.find_or_initialize_by(
      coupon_identifier: object.coupon.id,
      customer_identifier: object.customer,
      subscription_identifier: object.subscription&.id
    )
  end
end
