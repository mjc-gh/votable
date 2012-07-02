require 'test_helper'

class VotableCounterCacheTest < ActiveSupport::TestCase
  test "increases total cache on Vote" do
    u = create_user
    p = create_post

    u.cast_post_vote(p, 1)
    p.reload

    assert_equal 1, p.user_votes_total
  end

  test "decreases total cache on Vote" do
    u = create_user
    p = create_post

    u.cast_post_vote(p, -1)
    p.reload

    assert_equal -1, p.user_votes_total
  end

  test "total cache handles recasts" do
    u = create_user
    p = create_post

    u.cast_post_vote(p, 5)
    p.reload

    assert_equal 5, p.user_votes_total

    u.cast_post_vote(p, -2)
    p.reload

    assert_equal -2, p.user_votes_total
  end

  test "total cache with multiple Voters" do
    p = create_post

    3.times { create_user.cast_post_vote(p, 1) }
    p.reload

    assert_equal 3, p.user_votes_total

    create_user.cast_post_vote(p, -1)
    p.reload

    assert_equal 2, p.user_votes_total
  end
end
