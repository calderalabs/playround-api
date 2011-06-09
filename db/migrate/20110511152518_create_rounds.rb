class CreateRounds < ActiveRecord::Migration
  def self.up
    create_table :rounds do |t|
      t.references :user
      t.references :arena
      t.references :game
      t.text :description
      t.datetime :deadline
      t.datetime :date
      t.boolean :confirmed, :default => false
      t.integer :max_people, :default => 2
      t.integer :min_people, :default => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :rounds
  end
end
