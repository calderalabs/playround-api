class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.references :user
      t.string   :image_file_name
      t.string   :image_content_type
      t.integer  :image_file_size
      t.datetime :image_updated_at
      t.string :name, :limit => 30
      t.text :description
      t.string :website

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
