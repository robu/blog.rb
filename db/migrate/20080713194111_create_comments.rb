class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :post_id
      t.string :commenter_name
      t.string :commenter_email
      t.string :commenter_url
      t.string :title
      t.text :body_source
      t.text :body_html
      t.string :moderation_status

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
