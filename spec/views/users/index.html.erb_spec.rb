require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/index.html.erb" do
  include UsersHelper
  
  before(:each) do
    assigns[:users] = [
      stub_model(User,
        :username => "value for username",
        :hashed_password => "value for hashed_password",
        :password_salt => "value for password_salt",
        :first_name => "value for first_name",
        :last_name => "value for last_name"
      ),
      stub_model(User,
        :username => "value for username",
        :hashed_password => "value for hashed_password",
        :password_salt => "value for password_salt",
        :first_name => "value for first_name",
        :last_name => "value for last_name"
      )
    ]
  end

  it "should render list of users" do
    render "/users/index.html.erb"
    response.should have_tag("tr>td", "value for username", 2)
    response.should have_tag("tr>td", "value for hashed_password", 2)
    response.should have_tag("tr>td", "value for password_salt", 2)
    response.should have_tag("tr>td", "value for first_name", 2)
    response.should have_tag("tr>td", "value for last_name", 2)
  end
end

