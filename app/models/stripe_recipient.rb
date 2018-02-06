class StripeRecipient < StripeModelCallbacks::ApplicationRecord
  self.primary_key = "id"

  def assign_from_stripe(object)
    assign_attributes(
      stripe_type: object.type
    )

    StripeModelCallbacks::AttributesAssignerService.execute!(
      model: self, stripe_model: object,
      attributes: %w[active_account description email name migrated_to verified]
    )
  end

  def to_stripe
    @_to_stripe ||= Stripe::Recipient.retrieve(id)
  end
end
