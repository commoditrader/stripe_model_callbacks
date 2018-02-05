class StripeModelCallbacks::BaseEventService < ServicePattern::Service
  attr_reader :event, :object

  def self.reported_execute!(*args, &blk)
    with_exception_notifications do
      response = execute!(*args, &blk)
      raise response.errors.join(". ") unless response.success?
      return response
    end
  end

  def self.with_exception_notifications
    yield
  rescue => e # rubocop:disable Style/RescueStandardError
    Rails.logger.error "ERROR: #{e.message}"

    cleaned = Rails.backtrace_cleaner.clean(e.backtrace)
    if cleaned.any?
      Rails.logger.error cleaned
    else
      Rails.logger.error e.backtrace
    end

    ExceptionNotifier.notify_exception(e) if Rails.env.production?
  end

  def initialize(event: nil, object: nil)
    @event = event
    @object = object
    @object ||= event.data.object
  end
end
