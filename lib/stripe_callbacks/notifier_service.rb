class StripeCallbacks::NotifierService < StripeCallbacks::BaseEventService
  def execute!
    puts "NEW EVENT: #{event.type}"

    ServicePattern::Response.new(success: true)
  end
end
