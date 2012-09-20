class VoteMigration < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.boolean    :rating, :default => 1
      t.references :voteable, :polymorphic => true, :null => false
      t.references :user_id
      t.timestamps      
    end

    add_index :votes, ["voteable_id", "voteable_type"]
  end

  def self.down
    drop_table :votes
  end
end
