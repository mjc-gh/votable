class AddVotableCacheToPost < ActiveRecord::Migration
  def change
    add_column :posts, :user_votes_total, :integer
  end
end
