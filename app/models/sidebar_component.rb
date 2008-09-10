class SidebarComponent < ActiveRecord::Base
  belongs_to :blog
  acts_as_list :scope => :blog
end

