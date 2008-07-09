require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attributes = {
      :username => "robert",
      :hashed_password => "12381623871628736",
      :password_salt => "87293847293874",
      :first_name => "Robert",
      :last_name => "Buren"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
end
