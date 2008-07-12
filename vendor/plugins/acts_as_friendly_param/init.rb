# 
# load acts_as_friendly_param plugin and include the macro on
# AR::Base
#
require 'acts_as_friendly_param'
ActiveRecord::Base.send :include, ActiveRecord::Acts::FriendlyParam

# load a filter to catch RecordMoved redirect errors
#
require 'friendly_filter'
ActionController::Base.send :around_filter, ActionController::FriendlyFilter.new