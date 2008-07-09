require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/show.html.erb" do
  include UsersHelper
  
  before(:each) do
    assigns[:user] = @user = stub_model(User,
      :username => "value for username",
      :hashed_password => "value for hashed_password",
      :password_salt => "value for password_salt",
      :first_name => "value for first_name",
      :last_name => "value for last_name"
    )
  end

  it "should render attributes in <p>" do
    render "/users/show.html.erb"
    response.should have_text(/value\ for\ username/)
    response.should have_text(/value\ for\ hashed_password/)
    response.should have_text(/value\ for\ password_salt/)
    response.should have_text(/value\ for\ first_name/)
    response.should have_text(/value\ for\ last_name/)
  end
end

