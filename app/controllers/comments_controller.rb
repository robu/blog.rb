class CommentsController < ApplicationController
  before_filter :load_post
  layout nil

  # GET messages_url
  def index
    @comments = @post.comments.find(:all, :order => "created_at desc")
  end

  # GET new_message_url
  def new
    # return an HTML form for describing a new message
  end

  # POST messages_url
  def create
    if (@comment = @post.comments.create(params[:comment]))
      render :text => "Your comment has been saved. Thank you!"
    else
      @comment.errors.add_to_base "Unable to save comment. Please try again later."
      render :partial => "form"
    end
  end

  # GET message_url(:id => 1)
  def show
    # find and return a specific message
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
  def load_post
    @post = Post.find(params[:post_id])
  end
end
