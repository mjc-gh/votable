require 'test_helper'

class VotableConfigTest < ActiveSupport::TestCase
  test "Votable.setup sets default_options" do
    Votable.setup do |config|
      config.default_vote_class = 'Thing'
      config.allow_recast = false
    end

    assert_equal 'Thing', Votable.default_vote_class
    assert_equal false, Votable.allow_recast

    Votable.default_vote_class = 'Vote'
    Votable.allow_recast = true
  end
end
