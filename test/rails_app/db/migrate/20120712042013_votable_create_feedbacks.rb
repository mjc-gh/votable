class VotableCreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :voter
      t.references :votable

      t.string :votable_type
      t.string :voter_type

      t.string :scope

      #t.string :direction
      t.integer :value
    end

    add_index :feedbacks, :voter_id
    add_index :feedbacks, :votable_id

    #add_index :feedbacks, [:voter_id, :voter_type, :votable_type]
    #add_index :feedbacks, [:voter_id, :voter_type, :votable_type, :votable_id]
  end
end
