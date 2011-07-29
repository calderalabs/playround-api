class AddStateMachineToRounds < ActiveRecord::Migration
  def self.up
    change_table :rounds do |t|
      t.remove :confirmed
      t.remove :approved
      t.string :state
    end
  end

  def self.down
    change_table :rounds do |t|
      t.boolean :confirmed, :default => false
      t.boolean :approved, :default => false
      t.remove :state
    end
  end
end
