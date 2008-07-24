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

  def tags
    self.posts.map(&:tags).flatten.uniq.sort {|t1,t2| t1.name <=> t2.name}
  end

  def self.default
    blog = self.find(:first, :conditions => "default_blog=true")
    blog || (self.count == 1 ? self.first : nil)
  end
  
  protected
  def validate
    invalid_blog_names = %w(blogs posts users admin tags application sessions index new create update destroy show delete save post get)
    errors.add("path_name", "'#{path_name}' is not available") if invalid_blog_names.include?(path_name)
  end
  
  def before_save
    if self.default_blog
      connection.update_sql "update blogs set default_blog=false where default_blog=true"
    end
  end
end
