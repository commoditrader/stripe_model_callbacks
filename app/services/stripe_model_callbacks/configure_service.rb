class StripeModelCallbacks::ConfigureService < StripeModelCallbacks::BaseEventService
  attr_reader :events

  def initialize(events:)
    @events = events
  end

  def execute!
    events.all do |event|
      StripeModelCallbacks::NotifierService.reported_execute!(event: event)
    end

    events.subscribe "customer.source.updated" do |event|
      StripeModelCallbacks::Customer::SourceUpdatedService.reported_execute!(event: event)
    end

    events.subscribe "charge.refund.updated" do |event|
      StripeModelCallbacks::Refund::UpdatedService.reported_execute!(event: event)
    end

    customer_events
    invoice_item_events
    charge_events
    subscription_events
    invoice_events
    order_events
    plan_events
  end

private

  def charge_events
    %w[captured failed pending refunded updated succeeded].each do |charge_event|
      events.subscribe "charge.#{charge_event}" do |event|
        StripeModelCallbacks::Charge::UpdatedService.reported_execute!(event: event)
      end
    end
  end

  def customer_events
    %w[created deleted updated].each do |customer_event|
      events.subscribe "customer.#{customer_event}" do |event|
        StripeModelCallbacks::Customer::UpdatedService.reported_execute!(event: event)
      end
    end
  end

  def invoice_events
    %w[created updated payment_failed payment_succeeded sent upcoming updated].each do |invoice_event|
      events.subscribe "invoice.#{invoice_event}" do |event|
        StripeModelCallbacks::Invoice::UpdatedService.reported_execute!(event: event)
      end
    end
  end

  def invoice_item_events
    %w[created deleted updated].each do |event_type|
      events.subscribe "invoiceitem.#{event_type}" do |event|
        StripeModelCallbacks::InvoiceItem::UpdatedService.reported_execute!(event: event)
      end
    end
  end

  def order_events
    %w[created updated].each do |order_event|
      events.subscribe "order.#{order_event}" do |event|
        StripeModelCallbacks::Order::UpdatedService.reported_execute!(event: event)
      end
    end
  end

  def plan_events
    %w[created deleted updated].each do |plan_event|
      events.subscribe "plan.#{plan_event}" do |event|
        StripeModelCallbacks::Plan::UpdatedService.reported_execute!(event: event)
      end
    end
  end

  def subscription_events
    %w[created updated deleted].each do |subscription_event|
      events.subscribe "customer.subscription.#{subscription_event}" do |event|
        StripeModelCallbacks::Customer::Subscription::UpdatedService.reported_execute!(event: event)
      end
    end
  end
end
