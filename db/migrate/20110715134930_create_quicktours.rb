class CreateQuicktours < ActiveRecord::Migration
  def self.up
    create_table :quicktours do |t|
      t.references :user
      t.integer :current_guider, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :quicktours
  end
end
