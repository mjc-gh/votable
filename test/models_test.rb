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

  test "associates Vote to Voter" do
    u = create_user
    p = create_post

    u.cast_post_vote(p, 1)
    u.reload

    vote = Vote.first

    assert_equal u, vote.voter
    assert_equal u.post_votes.first, vote
  end

  test "associates Vote to Votable" do
    u = create_user
    p = create_post

    u.cast_post_vote(p, 1)
    p.reload

    vote = Vote.first

    assert_equal p, vote.votable
    assert_equal p.user_votes.first, vote
  end

  test "casts vote from Voter" do
    u = create_user
    p = create_post

    u.cast_post_vote(p, 1)
    u.reload

    assert_equal 1, u.post_votes.size
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
    u.reload

    assert_equal 1, u.post_votes.size
    assert_equal 1, u.question_votes.size

    assert_equal p, u.post_votes.first.votable
    puts u.question_votes.inspect
    assert_equal q, u.question_votes.first.votable
  end
end
