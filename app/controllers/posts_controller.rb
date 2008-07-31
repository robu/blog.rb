class PostsController < ApplicationController
  layout "blogs"
  before_filter :check_logged_in, :except => ['index', 'show']

  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.published

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])
    @blog = @post.blog
    @comments = @post.comments.find(:all, :order => "created_at asc")

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @blog = Blog.find(params[:blog])
    @post = Post.new
    @post.blog = @blog
    unless @blog.users.include? logged_in_user
      flash[:error] = "Access Denied"
      redirect_to_referer(blogs_path(:user => @logged_in_user))
      return
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @blog = @post.blog
    unless @blog.users.include? logged_in_user
      flash[:error] = "Access Denied"
      redirect_to_referer(blogs_path(:user => @logged_in_user))
    end
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    @post.blog = Blog.find(params[:post][:blog_id])
    @post.content_images << ContentImage.new(:uploaded_data => params[:content_image]) if params[:content_image]
    return unless @post.blog.users.include? logged_in_user

    respond_to do |format|
      if @post.save
        @post.users << logged_in_user unless @post.users.include?(logged_in_user)
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to(@post) }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])
    return unless @post.blog.users.include? logged_in_user

    respond_to do |format|
      if @post.update_attributes(params[:post])
        @post.users << logged_in_user unless @post.users.include?(logged_in_user)
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to(@post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    return unless @post.blog.users.include? logged_in_user
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
end
