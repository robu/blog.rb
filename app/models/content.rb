require 'redcloth'

class Content < ActiveRecord::Base
  validates_presence_of :target
  
  def to_s
    self.target
  end
  
  def before_validation
    if self.source
      self.target = RedCloth.new(self.source).to_html
    end
  end
end