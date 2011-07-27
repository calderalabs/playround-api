class AddRejectedToRounds < ActiveRecord::Migration
  def self.up
    add_column :rounds, :rejected, :boolean, :default => false
  end

  def self.down
    remove_column :rounds, :rejected
  end
end
