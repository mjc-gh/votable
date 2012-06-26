module Votable
  module JoinVote
    extend ActiveSupport::Concern

    included do |base|
      belongs_to :votable, :polymorphic => true
      belongs_to :voter, :polymorphic => true

      validates :votable_id, :voter_id, :presence => true

      attr_accessible :value
    end

    module ClassMethods
      def votable(options)
        if options[:unique] || options[:once_per]
          validates :voter_id, :uniqueness => { :scope => [:votable_id, :votable_type] }
        end
      end
    end
  end

  # TODO for mongodb/mongoid
  # module EmbeddableVote
  # module ChunkableVote
end
