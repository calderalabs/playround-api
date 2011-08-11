class AddWinnerToRounds < ActiveRecord::Migration
  def self.up
    add_column :rounds, :winner_id, :integer
  end

  def self.down
    remove_column :rounds, :winner_id
  end
end
