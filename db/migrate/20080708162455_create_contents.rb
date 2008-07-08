class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      t.text :target
      t.text :source
      t.string :source_type

      t.timestamps
    end
  end

  def self.down
    drop_table :contents
  end
end
