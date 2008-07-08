class Content < ActiveRecord::Base; end

class UseContentsTableForPosts < ActiveRecord::Migration

  def self.up
    add_column :posts, :content_id, :integer
    Post.all.each do |post|
      c = Content.create :target => post.body
      post.content = c
    end
    remove_column :posts, :body
  end

  def self.down
    add_column :posts, :body, :text
    Post.all.each do |post|
      post.body = post.content.target
      post.content.destroy
    end
    remove_column :posts, :content_id
  end
end
