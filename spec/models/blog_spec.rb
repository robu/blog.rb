require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Blog do
  before(:each) do
    @valid_attributes = {
      :path_name => "path_name_for_blog",
      :name => "value for name",
      :description => "value for description"
    }
  end

  it "should create a new instance given valid attributes" do
    Blog.create!(@valid_attributes)
  end

  it "should not allow an invalid pathname as path_name" do
    invalid_chars = "!<>|'%/()=?&åäöéëüê*;:,".chars
    invalid_chars.each_char do |c|
      @valid_attributes[:path_name] = c
      lambda {Blog.create!(@valid_attributes)}.should raise_error
    end
  end
  
  it "should allow valid path names as path_name" do
    valid_chars = "abcdefghijklmnopqrstuvwxyz0123456789_-."
    valid_chars.each_char do |c|
      @valid_attributes[:path_name] = c
      b = Blog.create!(@valid_attributes)
      b.should be_valid
    end
  end
  
  it "should not allow more than one Blog with the same path_name" do
    @valid_attributes[:path_name] = "roberts_blog"
    lambda{Blog.create!(@valid_attributes)}.should_not raise_error
    lambda{Blog.create!(@valid_attributes)}.should raise_error
  end
  
  it "should not allow a Blog without a name" do
    @valid_attributes[:name] = nil
    lambda{Blog.create!(@valid_attributes)}.should raise_error
  end
end
