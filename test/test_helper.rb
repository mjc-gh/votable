# Configure Rails Environment
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

# TODO handle testing of different ORMs
require 'orm/active_record'

# for testing generators
require "rails/generators/test_case"
require "generators/votable/install_generator"
require "generators/active_record/votable_generator"
