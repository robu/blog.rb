class FeedController < ApplicationController
  def index
    @blog = Blog.find(params[:id])
    @posts = @blog.published_posts.find(:all, :limit => 10)
  end

end
