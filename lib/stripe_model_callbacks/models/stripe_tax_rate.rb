class StripeTaxRate < StripeModelCallbacks::ApplicationRecord
  has_many :stripe_subscription_default_tax_rates, dependent: :destroy

  def self.stripe_class
    Stripe::TaxRate
  end

  def assign_from_stripe(object)
    assign_attributes(
      created: Time.zone.at(object.created),
      inclusive: object.inclusive == true,
      stripe_id: object.id
    )

    StripeModelCallbacks::AttributesAssignerService.execute!(
      model: self,
      stripe_model: object,
      attributes: %w[display_name description jurisdiction percentage inclusive]
    )
  end
end
