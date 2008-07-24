class TagsController < ApplicationController
  before_filter :load_blog
  layout "blogs"

  # GET messages_url
  def index
    @tags = @blog.tags
  end

  # GET new_message_url
#  def new
#  end

  # POST messages_url
#  def create
#  end

  # GET message_url(:id => 1)
  def show
    @tag = Tag.find(params[:id])
    render :file => "#{RAILS_ROOT}/public/404.html", :status => 404 and return unless @tag and @blog.tags.include?(@tag)
    @posts = @tag.taggings.map(&:taggable).sort {|p1,p2| p2.published_at <=> p1.published_at}
    @title = @tag.name if params[:show_title]
    @post = Post.find(params[:post_id]) if params[:post_id]
    render :layout => false
  end

  # GET edit_message_url(:id => 1)
#  def edit
    # return an HTML form for editing a specific message
#  end

  # PUT message_url(:id => 1)
#  def update
    # find and update a specific message
#  end

  # DELETE message_url(:id => 1)
#  def destroy
    # delete a specific message
#  end
  
  protected
  def load_blog
    @blog = Blog.find(params[:blog_id])
  end
end

