class AssociatePostsWithUsers < ActiveRecord::Migration
  def self.up
    create_table :posts_users, :id => false do |t|
      t.integer :post_id
      t.integer :user_id
    end
    
    Post.all.each do |post|
      post.blog.users.each {|u| post.users << u}
    end
  end

  def self.down
    drop_table :posts_users
  end
end
