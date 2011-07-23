class RemoveDeadlineAndMinMaxPeopleFromRounds < ActiveRecord::Migration
  def self.up
    change_table :rounds do |t|
      t.remove :deadline
      t.remove :min_people
      t.rename :max_people, :people
    end
  end

  def self.down
    change_table :rounds do |t|
      t.datetime :deadline
      t.integer :min_people, :default => 2
      t.rename :people, :max_people
    end
  end
end
