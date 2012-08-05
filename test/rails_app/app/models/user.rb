class User < ActiveRecord::Base
  attr_accessible :name

  votes_on :posts, :questions

  # multiple votable associations between Users and Comments via Feedback model
  votes_on :helpfull_comments, :quality_comments, vote_class: 'Feedback', votable_class: 'Comment'
end
