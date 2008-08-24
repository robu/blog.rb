class SidebarsController < ApplicationController
  before_filter :load_dependent
  layout "blogs"

  def index
    @sidebar_components = @blog.sidebar_components
  end

  protected
  def load_dependent
    @blog = Blog.find(params[:blog_id])
  end
end
