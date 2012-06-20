require 'test_helper'

class InstallGeneratorTest < Rails::Generators::TestCase
  tests Votable::Generators::InstallGenerator

  destination File.expand_path('../../tmp', __FILE__)
  setup :prepare_destination

  test 'Assert files are created' do
    run_generator

    assert_file 'config/initializers/votable.rb'
  end
end
