class ContentImage < ActiveRecord::Base
  has_attachment :content_type => :image
  validates_as_attachment

  belongs_to :owner, :polymorphic => true
  belongs_to :user
  belongs_to :db_file
end
