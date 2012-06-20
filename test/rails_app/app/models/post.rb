class Post < ActiveRecord::Base
  attr_accessible :title

  votable_by :users
end
