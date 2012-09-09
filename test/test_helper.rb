# Configure Rails Environment
VOTABLE_ORM = (ENV['VOTABLE_ORM'] || :active_record).to_sym
ENV["RAILS_ENV"] = "test"

require File.expand_path("../rails_app/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end


# for testing generators
require "rails/generators/test_case"
require "generators/votable/install_generator"
require "generators/active_record/votable_generator"
