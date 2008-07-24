class Post < ActiveRecord::Base
  belongs_to :blog
  belongs_to :content
  has_many :comments
  has_and_belongs_to_many :users

  acts_as_friendly_param :title
  acts_as_taggable_on :tags

  validates_presence_of :title
  validates_length_of :title, :maximum => 250
  
#  validates_presence_of :body
#  validates_length_of :body, :maximum => 50000
  
  validates_presence_of :blog_id
  
  attr_protected :blog_id
  
  named_scope :published, lambda { {:conditions => ["published_at is not null and published_at < ?", Time.now], :order => "published_at desc"} }
  named_scope :unpublished, lambda { {:conditions => ["published_at is null or published_at >= ?", Time.now], :order => "updated_at desc"} }
  
  def body
    content.target if content
  end

  def body=(text)
    if self.content
      self.content.source = text
      self.content.save!
    else
      self.content = Content.create! :source => text
    end
  end  
end
