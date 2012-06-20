#require 'orm_adapter'

require 'votable/version'
require 'votable/model'
require 'votable/vote'

module Votable
  class Engine < Rails::Engine
    config.votable = Votable

    initializer 'votable.insert_into_orm' do
      ActiveSupport.on_load :active_record do
        ActiveRecord::Base.extend Votable::Model
      end
      #
      # TODO why doesnt this get called
      #ActiveSupport.on_load :mongoid do
      #  Mongoid::Document::ClassMethod.send :incude, Votable::Model
      #end
    end

  end

  def self.setup
    yield self
  end

  mattr_accessor :default_options
  @@default_options = {
    :vote_class => 'Vote'
  }

  %w[ voter_class ].each do |method|
    module_eval do
      define_method(method) { |opt| @@default_options[opt] }
    end
  end
end
