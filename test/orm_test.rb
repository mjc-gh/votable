require 'test_helper'

class ORMTest < ActiveSupport::TestCase
  test "extends active_record" do
    skip "ActiveRecord is not available" unless defined?(ActiveRecord)

    model = Class.new(ActiveRecord::Base)

    #assert_includes model.methods, :votable
    #assert_includes model.methods, :votes_on
  end

  #test "includes for Mongoid Document" do
    #skip "Mongoid is not available" unless defined?(Mongoid)

    # TODO update this once mongoid AS::on_load is resolved
    #model = Class.new do
    #  include Mongoid::Document
    #  extend Votable::Model
    #end
    #assert_includes model.methods, :votable
    #assert_includes model.methods, :votes_on
  #end
end
