class CreateArenas < ActiveRecord::Migration
  def self.up
    create_table :arenas do |t|
      t.float :latitude, :default => 0
      t.float :longitude, :default => 0
      t.string :name, :limit => 30
      t.text :description
      t.string :website
      
      t.timestamps
    end
  end

  def self.down
    drop_table :arenas
  end
end
