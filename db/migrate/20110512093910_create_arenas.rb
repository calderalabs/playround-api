class CreateArenas < ActiveRecord::Migration
  def self.up
    create_table :arenas do |t|
      t.references :user
      t.string   :image_file_name
      t.string   :image_content_type
      t.integer  :image_file_size
      t.datetime :image_updated_at
      t.float :latitude, :default => 0
      t.float :longitude, :default => 0
      t.integer :town_woeid, :limit => 8
      t.string :name, :limit => 30
      t.text :description
      t.string :website
      t.boolean :public, :default => false
      t.string :address
      
      t.timestamps
    end
  end

  def self.down
    drop_table :arenas
  end
end
