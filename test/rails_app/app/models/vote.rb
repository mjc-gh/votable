class Vote < ActiveRecord::Base
  include Votable::JoinVote
  votable unique: true
  # attr_accessible :title, :body
end
