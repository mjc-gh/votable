class VotableCreate<%= table_name.camelize %> < ActiveRecord::Migration
  def change
    create_table :<%= table_name %> do |t|
      t.references :voter
      t.references :votable

      t.string :votable_type
      t.string :voter_type

      #t.string :direction
      t.integer :value
    end

    add_index :<%= table_name %>, :voter_id
    add_index :<%= table_name %>, :votable_id
  end
end
