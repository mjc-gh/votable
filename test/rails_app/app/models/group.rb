class Group < ActiveRecord::Base
  votes_on :posts, allow_recast: false
  votes_on :questions


  attr_accessible :name
end
