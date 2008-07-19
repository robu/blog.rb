class Comment < ActiveRecord::Base
  belongs_to :post

  validates_presence_of :post_id
  validates_associated :post

  validates_presence_of :commenter_name
  validates_length_of :commenter_name, :maximum => 200
  
  validates_length_of :commenter_email, :maximum => 200, :allow_blank => true
  validates_length_of :commenter_url, :maximum => 250, :allow_blank => true
  
  validates_length_of :title, :maximum => 250, :allow_blank => true
  validates_length_of :body_source, :maximum => 5000, :allow_blank => true

  validates_presence_of :title, :unless => Proc.new {|comment| comment.body_source}, :message => " or body must be present"
  validates_presence_of :body_source, :unless => Proc.new {|comment| comment.title}, :message => " or title must be present"
  
  def body
    body_html || body_source
  end
end
