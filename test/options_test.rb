require 'test_helper'

class VoterDependentTest < VotableTestBase
  votes_on :comments, dependent: :destroy
  votes_on :posts, dependent: :nullify
end

class VotableModelOptionsTest < ActiveSupport::TestCase
  test "voter dependent option" do
    assocs = VoterDependentTest.reflect_on_all_associations

    assert_equal :destroy, assocs.find { |a| a.name == :comment_votes }.options[:dependent]
    assert_equal :nullify, assocs.find { |a| a.name == :post_votes }.options[:dependent]

    assocs.select { |a| a.name.to_s =~ /_votables$/ }.each do |assoc|
      assert_nil assoc.options[:dependent]
    end
  end
end
