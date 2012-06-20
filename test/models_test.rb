require 'test_helper'

class VotableModelTest < ActiveSupport::TestCase
  test "creates voter associations" do
    u = create_user

    assert_empty u.post_votes
    assert_empty u.post_votables
  end

  test "creates votable association" do
    p = create_post

    assert_empty p.user_votes
    assert_empty p.user_voters
  end

  test "casts vote from Voter" do
    u = create_user
    p = create_post

    u.cast_post_vote(p, 1)
    u.reload

    assert u.post_votes.any?
    vote = u.post_votes.first

    assert_equal vote.voter, u
    assert_equal vote.votable, p
  end

  test "casts one vote per Voter" do
    u = create_user
    p = create_post

    u.cast_post_vote(p, 1)
    u.cast_post_vote(p, 1)
    u.reload

    assert_equal 1, u.post_votes.size
  end
end
