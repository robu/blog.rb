require 'sha1'

class User < ActiveRecord::Base
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_length_of :username, :in => 4..30
  has_and_belongs_to_many :blogs, :join_table => "users_blogs"
  
  attr_accessor :password
  attr_protected :password
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def before_save
    self.password_salt = new_salt()
    self.hashed_password = digested(self.password, self.password_salt)
  end
  
  def verify_password(pw)
    self.hashed_password == digested(pw, self.password_salt)
  end
  
  private
  def new_salt
    Digest::SHA1.hexdigest(Time.now.usec.to_s)
  end
  
  def digest_string(pw, salt)
    "SecretString-#{pw}-#{salt}"
  end
  
  def digested(pw, salt)
    Digest::SHA1.hexdigest(digest_string(pw, salt))
  end
end
