class User < ActiveRecord::Base
  attr_accessible :name

  votes_on :posts, :questions
end
