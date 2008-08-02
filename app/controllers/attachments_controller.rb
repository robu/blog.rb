class AttachmentsController < ApplicationController
  before_filter :load_dependent
  layout nil

  # GET messages_url
  def index
    @content_images = @post.content_images
  end

  # GET new_message_url
  def new
    # return an HTML form for describing a new message
  end

  # POST messages_url
  def create
  end

  # GET message_url(:id => 1)
  def show
    @content_image = @post.content_images.find(params[:id]) if @post
#    @content_image = @blog.content_images.find(params[:id]) if @blog
    headers['Content-Length'] = @content_image.size
    send_data @content_image.db_file.data, 
      :type => @content_image.content_type, 
      :disposition => 'inline', 
      :filename => @content_image.filename
  end

  # GET edit_message_url(:id => 1)
  def edit
    # return an HTML form for editing a specific message
  end

  # PUT message_url(:id => 1)
  def update
    # find and update a specific message
  end

  # DELETE message_url(:id => 1)
  def destroy
    # delete a specific message
  end
  
  protected
  def load_dependent
    @post = Post.find(params[:post_id]) if params[:post_id]
    @blog = Blog.find(params[:blog_id]) if params[:blog_id]
  end
end
