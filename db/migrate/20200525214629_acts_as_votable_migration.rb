class ActsAsVotableMigration < ActiveRecord::Migration[6.0]
  def self.up
    create_table :votes do |t|

      t.references :votable, polymorphic: true, type: :uuid
      t.references :voter, polymorphic: true, type: :uuid

      t.boolean :vote_flag
      t.string :vote_scope
      t.integer :vote_weight

      t.timestamps
    end

    add_index :votes, [:voter_id, :voter_type, :vote_scope]
    add_index :votes, [:votable_id, :votable_type, :vote_scope]
  end

  def self.down
    drop_table :votes
  end
end
