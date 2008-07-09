class Blog < ActiveRecord::Base
  has_many :posts
  has_and_belongs_to_many :users, :join_table => "users_blogs"

  validates_format_of :path_name, :with => /\A[abcdefghijklmnopqrstuvwxyz0123456789_\-\.]+\Z/
  validates_uniqueness_of :path_name
  
  validates_presence_of :name
  validates_length_of :name, :maximum => 80
  
  validates_length_of :description, :maximum => 200
  
  def published_posts
    self.posts.published
  end
  
  protected
  def validate
    invalid_blog_names = %w(blogs posts users admin)
    errors.add("path_name", "'#{path_name}' is not available") if invalid_blog_names.include?(path_name)
  end
end
