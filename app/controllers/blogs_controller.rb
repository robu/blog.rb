class BlogsController < ApplicationController
  before_filter :check_logged_in, :except => ['index', 'show']

  # GET /blogs
  # GET /blogs.xml
  def index
    if params[:user] && (user=User.find(params[:user]))
      @blogs = user.blogs
    else
      @blogs = Blog.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @blogs }
    end
  end

  # GET /blogs/1
  # GET /blogs/1.xml
  def show
    if params[:id]
      @blog = Blog.find(params[:id])
      redirect_to "/#{@blog.path_name}"
      return
    end
    @blog = Blog.find_by_path_name(params[:path_name])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @blog }
    end
  end

  # GET /blogs/new
  # GET /blogs/new.xml
  def new
    @blog = Blog.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @blog }
    end
  end

  # GET /blogs/1/edit
  def edit
    @blog = Blog.find(params[:id])
    unless @blog.users.include?(logged_in_user)
      flash[:error] = "Sorry, no access!"
      redirect_to_referer(blogs_path(:user => logged_in_user))
    end
  end

  # POST /blogs
  # POST /blogs.xml
  def create
    @blog = Blog.new(params[:blog])

    respond_to do |format|
      if @blog.save
        @blog.users << logged_in_user
        flash[:notice] = 'Blog was successfully created.'
        format.html { redirect_to(@blog) }
        format.xml  { render :xml => @blog, :status => :created, :location => @blog }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @blog.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /blogs/1
  # PUT /blogs/1.xml
  def update
    @blog = Blog.find(params[:id])
    unless @blog.users.include?(logged_in_user)
      flash[:error] = "Sorry, no access!"
      redirect_to_referer(blogs_path(:user => logged_in_user))
      return
    end

    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        flash[:notice] = 'Blog was successfully updated.'
        format.html { redirect_to(@blog) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @blog.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.xml
  def destroy
    @blog = Blog.find(params[:id])
    unless @blog.users.include?(logged_in_user)
      flash[:error] = "Sorry, no access!"
      redirect_to_referer(blogs_path(:user => logged_in_user))
      return
    end
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to(blogs_url) }
      format.xml  { head :ok }
    end
  end
end
