class CreateContentImages < ActiveRecord::Migration
  def self.up
    create_table :content_images do |t|
      t.integer :size
      t.string :content_type
      t.string :filename
      t.integer :height
      t.integer :width
      t.integer :parent_id
      t.string :thumbnail
      t.integer :db_file_id
      t.integer :owner_id
      t.string :owner_type
      t.string :alt_text
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :content_images
  end
end
