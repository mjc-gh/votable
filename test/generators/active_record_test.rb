require 'test_helper'

class ActiveRecordGeneratorTest < Rails::Generators::TestCase
  tests ActiveRecord::Generators::VotableGenerator

  destination File.expand_path('../../tmp', __FILE__)
  setup :prepare_destination

  test 'creates model and migration files' do
    run_generator %w[caster]

    assert_file 'app/models/caster.rb', /class Caster/, /Votable::(\w+)Vote/
    assert_migration 'db/migrate/votable_create_casters.rb', /def change/, /create_table :casters/, /add_index/
  end
end
