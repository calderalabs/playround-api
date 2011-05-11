class CreateRounds < ActiveRecord::Migration
  def self.up
    create_table :rounds do |t|
      t.string :name
      t.text :description
      t.datetime :deadline
      t.datetime :date, :default => Date.now
      t.boolean :confirmed, :default => false
      t.integer :max_people, :default => 1
      t.integer :min_people, :default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :rounds
  end
end
