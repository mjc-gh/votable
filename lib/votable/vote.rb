module Votable
  module JoinVote
    extend ActiveSupport::Concern

    included do |base|
      belongs_to :votable, :polymorphic => true
      belongs_to :voter, :polymorphic => true

      validates :votable_id, :voter_id, :votable_type, :voter_type, :presence => true

      attr_accessible :value

      after_save do
        if value_changed?
          votable_klass = votable_type.constantize
          voter_cache = :"#{voter_type.downcase}_votes_total"

          if votable_klass.attribute_method? voter_cache
            if value_was
              votable_klass.update_counters votable_id, voter_cache => -1 * value_was
            end

            votable_klass.update_counters votable_id, voter_cache => value
          end
        end
      end
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
