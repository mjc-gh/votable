Votable
=======
[![Build Status](https://secure.travis-ci.org/mikeycgto/votable.png?branch=master)](http://travis-ci.org/mikeycgto/votable)

Highly customizable Voting system for Rails.

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
use the `votes_on` method to define what models they can vote on. For
example:

    class User < ActiveRecord::Base
      votes_on :posts, :questions
    end

Models which get voted on, are called Votables. These models use the
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
all objects they can vote on.

Continuing with the above example, the following would be available to
the User class:

     # cast an up Vote on a Post instance
     current_user.cast_post_vote(post_instance, 1)

     # cast a down Vote on a Question instance
     current_user.cast_question_vote(question_instance, -1)

Votable gives you complete control over what value of the vote actually
is. This provides a lot of flexibile 

## Vote Count Cache

Votable will automatically store a running total if the correct
attributes are defined. Vote counter caches should exist under the
Votable class. Thus, step one in adding a counter cache is to create
a migration for it. 

The name of the counter cache column should match whatever Voter type
you are keeping count of. For example, suppose you wanted to create a
counter cache for User votes on Posts:

    rails g migration AddVotableCacheToPosts user_votes_total:integer

Now, whenever a Vote is created or updated by a User for a Post, the
`user_votes_count` cache will be updated accordingly.

**Note:** The attribute name ends with `_total` rather than `_count`. 
This is done on purpose to avoid clashing with ActiveRecord's own 
`:counter_cache` options which is designed to track how manu instances
have been created. Eventually, Votable will add an option to enable 
the `:counter_cache` in order to track how many votes have been 
cast altogether for a given Voter and Votable.

_Coming Soon_ An API for customizable counter caches with different
conditions tied to them (ie. positive and negative values).

## Voter Methods

In addition to the vote casting method, the following methods are
also generated under the `_votes` association for the Voter class.

- `voted_on?(object, direction = nil)`

  The `voted_on?` method returns either `true` or `false`. You must call
  this method with either an instance of the Votable class or an ID.

  The method also takes an optional second argument. This can either 
  be: `:up`, `:down`, `:positive`, `:negative` or `nil` (the default)
  For example:
  
        # check if the current_user voted at all on a given Post
        current_user.post_votes.voted_on?(post_instance)

        # check if user voted up (positive) on a given Question
        current_user.question_votes.voted_on?(question_instance, :up)

## Feature TODO List

Here is a list of upcoming features and ideas. Feel free to submit pull
requests!

- API options for customizing association names. This will allow for
  mulitple votable relationships between the same models.

- Counter cache for pure vote total. Presently, we just track the
  running vote total. Can likely just leverage the existing
  `:counter_cache` options in ActiveRecord.

- Conditional counter caches to allow for custom countes with
  arbitrary logic tied to it (ie. positive and negative counts).

- Add options for allowing multiple votes for a given Voter and Votable.

- Vote value validation.

- Voter reputations. Support decreasing reputation on down\negative
  votes.
