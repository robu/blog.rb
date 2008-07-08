require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/blogs/new.html.erb" do
  include BlogsHelper
  
  before(:each) do
    assigns[:blog] = stub_model(Blog,
      :new_record? => true,
      :path_name => "value for path_name",
      :name => "value for name",
      :description => "value for description"
    )
  end

  it "should render new form" do
    render "/blogs/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", blogs_path) do
      with_tag("input#blog_path_name[name=?]", "blog[path_name]")
      with_tag("input#blog_name[name=?]", "blog[name]")
      with_tag("input#blog_description[name=?]", "blog[description]")
    end
  end
end


