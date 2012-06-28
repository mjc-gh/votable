Votable
=======
[![Build Status](https://secure.travis-ci.org/mikeycgto/votable.png?branch=master)](http://travis-ci.org/mikeycgto/votable)

## Installation & Setup

1. Install the gem by adding the following to your Gemfile:

        gem 'votable'

2. Install the plugin to your app. This will create a new initializer.
   This is where you can configure default options for votable.

        rails generate votable:install

3. Next you'll need to generate the Vote model and migration. Currently
   only ActiveRecord is supported.

        # usage: rails generate votable [NAME]
        rails g votable Vote

## Defining Voters and Votables

Next, in order to use votable, you need to define one more voter. Voters 
use the `votes_on` method to define what models they can vote on. 

For examle:

    class User < ActiveRecord::Base
      votes_on :posts, :questions
    end

Models which get voted on, are called votables. These models use the
`votable_by` method to define what Voters can vote on them.

    class Post < ActiveRecord::Base
      votable_by :users
    end

    class Question < ActiveRecord::Base
      votable_by :users
    end

Under the hood, the `votes_on` and `votable_by` methods, setup the
necessary relationships between you models.

In this example, User will now be realted to Vote records under the
`post_votes` and `question_votes` association. Since the relationship is
polymorphic, the types will also be included.

_Coming Soon_ Eventually, there will a rich enough API so one can relate
a given voter and votable model more than once. The key here is naming
the uniquely association (and generated methods)


## Casting Votes

Once you've defined Voters and Votables, you can now cast votes. Votable
automatically generates vote casting methods on the Voter class for
whatever they can vote on.

Continuing the above example, the following would be available to the
User class:

     # cast an up Vote on a Post instance
     current_user.cast_post_vote(post_instance, 1)

     # cast a down Vote on a Question instance
     current_user.cast_question_vote(question_instance, -1)

Votable gives you complete control over what value of the vote actually
is.

## Voter Methods

In addition to the generated cast vote method, the following methods are
also generated under the `_votes` association.

- `voted_on?(object, direction = nil)`

  The `voted_on?` method returns either `true` or `false`. It has
  one required argument, `object` which should be an instance of a
  votable model or an ID for the given vote association.

  The method also takes an optional second argument `direction`. This
  can either: `:up`, `:down`, `:positive`, `:negative` or `nil` (the 
  default)
  
  For example:
  
        # check if the current_user voted at all on a given Post
        current_user.post_votes.voted_on?(post_instance)

        # check if user voted up (positive) on a given Question
        current_user.question_votes.voted_on?(question_instance, :down)
