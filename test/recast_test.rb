class VotableRecastTest < ActiveSupport::TestCase
  test "User voter can recast Vote" do
    u = create_user
    p = create_post

    assert u.cast_post_vote(p, 1)
    assert_equal 1, u.post_votes.first.value

    assert u.cast_post_vote(p, -1)
    assert_equal -1, u.post_votes.first.value
  end

  test "Group voter cant recast Vote on Post" do
    g = create_group
    p = create_post

    assert g.cast_post_vote(p, 1)
    assert_equal 1, g.post_votes.first.value

    assert_equal false, g.cast_post_vote(p, -1)
    assert_equal 1, g.post_votes.first.value
  end

  test "Group voter can recast Vote on Question" do
    g = create_group
    q = create_question

    assert g.cast_question_vote(q, 1)
    assert_equal 1, g.question_votes.first.value

    assert g.cast_question_vote(q, -1)
    assert_equal -1, g.question_votes.first.value
  end
end
