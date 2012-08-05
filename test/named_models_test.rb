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
    
  end
end
