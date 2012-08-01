class User < ActiveRecord::Base
  attr_accessible :name

  votes_on :posts, :questions

  # multiple votable associations between Users and Comments to create a feedback
  votes_on :helpfull_comments, :quality_comments, vote_class: 'Feedback', votable_class: 'Comment'
end
