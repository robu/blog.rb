class SessionsController < ApplicationController
  def login
    @user = User.new
  end

  def create
    @user = User.find_by_username(params[:user][:username])
    if @user && @user.verify_password(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to blogs_path(:user => @user)
    else
      @user = User.new(params[:user])
      @user.errors.add_to_base "Invalid username or password"
      render :action => "login"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :controller => 'blogs'
  end

end
