require 'test_helper'

class VotableCounterCacheTest < ActiveSupport::TestCase
  test "increases counter cache on Vote" do
    u = create_user
    p = create_post

    u.cast_question_vote(p, 1)
    p.reload

    assert_equal 1, p.user_votes_total
  end
  
  test "decreases counter cache on Vote" do
    u = create_user
    p = create_post

    u.cast_question_vote(p, -1)
    p.reload

    assert_equal -1, p.user_votes_total
  end

  test "counter cache handles arbitrary values on Vote" do
    u = create_user
    p = create_post

    u.cast_question_vote(p, 13)
    p.reload

    assert_equal 13, p.user_votes_total
  end
end
