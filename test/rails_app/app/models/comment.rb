class Comment < ActiveRecord::Base
  votable_by :users

  attr_accessible :body
end
