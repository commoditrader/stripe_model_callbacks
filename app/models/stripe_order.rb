class StripeOrder < StripeModelCallbacks::ApplicationRecord
  belongs_to :charge,
    class_name: "StripeCharge",
    foreign_key: "charge_identifier",
    inverse_of: :orders,
    optional: true,
    primary_key: "identifier"

  belongs_to :customer,
    class_name: "StripeCustomer",
    foreign_key: "customer_identifier",
    inverse_of: :orders,
    optional: true,
    primary_key: "identifier"

  has_many :order_items,
    class_name: "StripeOrderItem",
    dependent: :destroy,
    foreign_key: "order_identifier",
    inverse_of: :order,
    primary_key: "identifier"

  monetize :amount_cents
  monetize :amount_returned_cents, allow_nil: true
  monetize :application_cents, allow_nil: true

  def assign_from_stripe(object)
    assign_attributes(
      charge_identifier: object.charge,
      created: Time.zone.at(object.created),
      currency: object.currency,
      customer_identifier: object.customer,
      email: object.email,
      livemode: object.livemode,
      metadata: JSON.generate(object.metadata),
      selected_shipping_method: object.selected_shipping_method,
      status: object.status,
      updated: Time.zone.at(object.updated)
    )

    assign_amounts_from_stripe(object)
    assign_shipping_address_from_stripe(object)
    assign_shipping_from_stripe(object)
  end

private

  def assign_amounts_from_stripe(object)
    assign_attributes(
      amount: Money.new(object.amount, object.currency),
      application: object.application ? Money.new(object.application, object.currency) : nil,
      application_fee: object.application_fee
    )
  end

  def assign_shipping_address_from_stripe(object)
    assign_attributes(
      shipping_address_city: object.shipping.address.city,
      shipping_address_country: object.shipping.address.country,
      shipping_address_line1: object.shipping.address.line1,
      shipping_address_line2: object.shipping.address.line2,
      shipping_address_postal_code: object.shipping.address.postal_code,
      shipping_address_state: object.shipping.address.state
    )
  end

  def assign_shipping_from_stripe(object)
    assign_attributes(
      shipping_carrier: object.shipping.carrier,
      shipping_name: object.shipping.name,
      shipping_phone: object.shipping.phone,
      shipping_tracking_number: object.shipping.tracking_number,
      shipping_methods: object.shipping_methods
    )
  end
end
