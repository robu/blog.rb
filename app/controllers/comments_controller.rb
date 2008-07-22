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
    
    @comment = Comment.new(params[:comment])
    @comment.post = @post
    
    if validate_recap(params, @comment.errors) && @comment.save
      render :update do |page|
        page[:comment_form].visual_effect :fade, :duration => 0.3
        page.insert_html :bottom, "comments", :partial => "comment", :locals => {:comment => @comment, :comment_counter => @post.comments.size+1}
        page.replace_html "comments_count_info", :partial => "posts/comments_count_info", :locals => {:comments => @post.comments}
        page[:comments_count_info].visual_effect :highlight, :duration => 4.0
        page["comment_#{@comment.id}".to_sym].scroll_to
        page["comment_#{@comment.id}".to_sym].visual_effect :highlight, :duration => 4.0
        page[:form_hide_link].hide
        page[:form_show_link].show
      end
    else
      @comment.errors.add_to_base "Unable to save comment. Please try again later."
      render :update do |page|
        page.replace_html "form_errors", @comment.errors.full_messages.join("<br/>")
      end
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
