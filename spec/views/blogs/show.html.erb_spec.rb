require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/blogs/show.html.erb" do
  include BlogsHelper
  
  before(:each) do
    assigns[:blog] = @blog = stub_model(Blog,
      :path_name => "value for path_name",
      :name => "value for name",
      :description => "value for description"
    )
  end

  it "should render attributes in <p>" do
    render "/blogs/show.html.erb"
    response.should have_text(/value\ for\ path_name/)
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ description/)
  end
end

