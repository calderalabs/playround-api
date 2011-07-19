class AddApprovedToRounds < ActiveRecord::Migration
  def self.up
    add_column :rounds, :approved, :boolean, :default => false
  end

  def self.down
    remove_column :rounds, :approved
  end
end
