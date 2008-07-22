# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ReCaptcha::AppHelper
  
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '0fde9f0bc56c9b6da270222dc90c98a5'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  helper_method :logged_in?, :logged_in_user
  
  def logged_in?
    !! session[:user_id]
  end
  
  def logged_in_user
    logged_in? ? User.find(session[:user_id]) : nil
  end
  
  def redirect_to_referer(backup_url)
      referer = request.headers['Referer']
      redirect_to referer || backup_url
  end
  
  def check_logged_in
    unless logged_in?
      flash[:error] = "You need to be logged in to access that page"
      redirect_to_referer(blogs_path())
    end
  end
end
