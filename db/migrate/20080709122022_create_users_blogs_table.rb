class CreateUsersBlogsTable < ActiveRecord::Migration
  def self.up
    create_table :users_blogs, :id => false do |t|
      t.integer :user_id
      t.integer :blog_id
    end
  end

  def self.down
    drop_table :users_blogs
  end
end
