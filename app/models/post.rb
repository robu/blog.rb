class Post < ActiveRecord::Base
  belongs_to :blog

  validates_presence_of :title
  validates_length_of :title, :maximum => 250
  
  validates_presence_of :body
  validates_length_of :body, :maximum => 50000
  
  validates_presence_of :blog_id
  
  named_scope :published, :conditions => "published_at is not null", :order => "published_at desc"
  named_scope :unpublished, :conditions => "published_at is null", :order => "updated_at desc"
end