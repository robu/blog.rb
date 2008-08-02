class UsersController < ApplicationController
  before_filter :check_logged_in, :only => ['destroy', 'update', 'edit', 'blogs']
  
  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    unless logged_in?
      # This is just to protect production environment to get spammed with new users
      flash[:error] = "Sorry, no access"
      redirect_to :controller => :default
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    unless logged_in_user == @user
      flash[:error] = "Sorry, no access"
      redirect_to_referer(users_path())
    end
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    @user.password = params[:user][:password]

    unless logged_in?
      # This is just to protect production environment to get spammed with new users
      flash[:error] = "Sorry, no access"
      redirect_to :controller => :default
    end
    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    unless logged_in_user == @user
      flash[:error] = "Sorry, no access"
      redirect_to_referer(users_path())
      return
    end
    @user.password = params[:password] if params[:password]

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    unless logged_in_user == @user
      flash[:error] = "Sorry, no access"
      redirect_to_referer(users_path())
      return
    end
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  def blogs
    @user = logged_in_user
    @blogs = @user.blogs
  end
end
