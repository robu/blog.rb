require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/blogs/index.html.erb" do
  include BlogsHelper
  
  before(:each) do
    assigns[:blogs] = [
      stub_model(Blog,
        :path_name => "value for path_name",
        :name => "value for name",
        :description => "value for description"
      ),
      stub_model(Blog,
        :path_name => "value for path_name",
        :name => "value for name",
        :description => "value for description"
      )
    ]
  end

  it "should render list of blogs" do
    render "/blogs/index.html.erb"
    response.should have_tag("tr>td", "value for path_name", 2)
    response.should have_tag("tr>td", "value for name", 2)
    response.should have_tag("tr>td", "value for description", 2)
  end
end

