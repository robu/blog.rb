class CreateSidebarComponents < ActiveRecord::Migration
  def self.up
    create_table :sidebar_components do |t|
      t.string :type
      t.integer :blog_id
      t.integer :position
      t.string :title
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :sidebar_components
  end
end
