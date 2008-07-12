# Error raised for mismatched titles
#
# idea is that you catch these errors and then perform a 301
# redirect to the correct page for the record stored in ex.record
#
class ActiveRecord::RecordMoved < ActiveRecord::RecordNotFound
  attr_reader :record
  
  def initialize(record)
    @record = record
  end
end