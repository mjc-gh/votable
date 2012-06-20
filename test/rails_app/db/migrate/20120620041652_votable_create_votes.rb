class VotableCreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :voter
      t.references :votable

      t.string :votable_type
      t.string :voter_type

      #t.string :direction
      t.integer :value
    end

    add_index :votes, :voter_id
    add_index :votes, :votable_id
  end
end
