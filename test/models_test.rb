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

  test "scopes Votes to id and type" do
    u = create_user

    p = create_post(id: 1)
    q = create_question(id: 1)

    u.cast_post_vote(p, 1)
    u.cast_question_vote(q, 1)

    assert_equal 1, u.post_votes.size
    assert_equal 1, u.question_votes.size
  end

  test "Voter can recast Vote" do
    u = create_user
    p = create_post

    assert u.cast_post_vote(p, 1)
    assert_equal 1, u.post_votes.first.value

    assert u.cast_post_vote(p, -1)
    assert_equal -1, u.post_votes.first.value
  end

  test "Voter cant recast Vote when disabled" do
    g = create_group
    p = create_post

    assert g.cast_post_vote(p, 1)
    assert_equal 1, g.post_votes.first.value

    assert_equal false, g.cast_post_vote(p, -1)
    assert_equal 1, g.post_votes.first.value
  end
end
