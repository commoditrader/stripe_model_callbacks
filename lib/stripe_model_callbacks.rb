require "auto_autoloader"
require "money-rails"
require "public_activity"
require "service_pattern"
require "stripe"
require "stripe_event"
require "stripe_model_callbacks/engine"
require "stripe_model_callbacks/autoload_models"

module StripeModelCallbacks
  path = "#{File.dirname(__FILE__)}/stripe_model_callbacks"

  autoload :EventMocker, "#{path}/event_mocker"
end
