Votable
=======
[![Build Status](https://secure.travis-ci.org/mikeycgto/votable.png?branch=master)](http://travis-ci.org/mikeycgto/votable)

## Overview

_TODO_ Update README :D

## Installation & Setup

1. Install the gem by adding the following to your Gemfile:

        gem 'votable'

   Now run

2. Install the plugin to your app. This will create a new initializer.

        rails generate votable:install

3. Next you'll need to generate the Vote model and migration. Currently
only ActiveRecord is supported.

        # usage: rails generate votable [NAME]
        rails g votable Vote

4. Now define some Voters and Votables:

        class User
          votes_on :posts
        end

        class Post
          votable_by :users
        end


5. Now Voters can cast votes:

        current_user.cast_vote(post_instance, 1)
