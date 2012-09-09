require 'test_helper'

class VotableNamedModelTest < ActiveSupport::TestCase
  test "handles two scoped associations" do
    u = create_user
    c = create_comment

    u.cast_helpfull_comment_vote(c, 5)
    u.cast_quality_comment_vote(c, -5)
    u.reload

    assert_equal 1, u.helpfull_comment_votes.size
    assert_equal 1, u.quality_comment_votes.size

    assert_equal 5, u.helpfull_comment_votes.first.value
    assert_equal -5, u.quality_comment_votes.first.value
  end

  test "voted_on? handles two scoped associations" do
    u = create_user
    c1 = create_comment
    c2 = create_comment

    u.cast_helpfull_comment_vote(c1, 5)
    u.cast_quality_comment_vote(c1, -5)

    u.cast_helpfull_comment_vote(c2, -5)
    u.cast_quality_comment_vote(c2, 5)

    assert u.helpfull_comment_votes.voted_on?(c1, :positive)
    assert u.quality_comment_votes.voted_on?(c1, :negative)

    assert u.helpfull_comment_votes.voted_on?(c2, :negative)
    assert u.quality_comment_votes.voted_on?(c2, :positive)
  end
end
