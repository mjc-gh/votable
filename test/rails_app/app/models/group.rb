class Group < ActiveRecord::Base
  votes_on :posts, :questions, allow_recast: false

  attr_accessible :name
end
