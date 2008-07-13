class DefaultController < ApplicationController
  def index
    @blog = Blog.default
    unless @blog
      redirect_to blogs_path
      return
    end
    @posts = @blog.published_posts.paginate :page => params[:page], :per_page => 10
    respond_to do |format|
      format.html { render :template => 'blogs/show', :layout => 'blogs' }
      format.xml  { render :xml => @blog }
    end
  end
end
