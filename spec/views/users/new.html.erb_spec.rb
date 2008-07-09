require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/new.html.erb" do
  include UsersHelper
  
  before(:each) do
    assigns[:user] = stub_model(User,
      :new_record? => true,
      :username => "value for username",
      :hashed_password => "value for hashed_password",
      :password_salt => "value for password_salt",
      :first_name => "value for first_name",
      :last_name => "value for last_name"
    )
  end

  it "should render new form" do
    render "/users/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", users_path) do
      with_tag("input#user_username[name=?]", "user[username]")
      with_tag("input#user_hashed_password[name=?]", "user[hashed_password]")
      with_tag("input#user_password_salt[name=?]", "user[password_salt]")
      with_tag("input#user_first_name[name=?]", "user[first_name]")
      with_tag("input#user_last_name[name=?]", "user[last_name]")
    end
  end
end


