# Load the rails application
require File.expand_path('../application', __FILE__)

::ActiveSupport::Deprecation.silenced = true if Rails.env.production?
# ::ActiveSupport::Deprecation.silenced = true

# Initialize the rails application
EveryLastMorsel::Application.initialize!