module Votable
  module JoinVote
    extend ActiveSupport::Concern

    included do |base|
      belongs_to :votable, :polymorphic => true
      belongs_to :voter, :polymorphic => true

      validates :votable_id, :voter_id, :presence => true
      validates :voter_id, :uniqueness => { :scope => :votable_id }

      attr_accessible :value
    end
  end

  # TODO for mongodb/mongoid
  # module EmbeddableVote
  # module ChunkableVote
end
