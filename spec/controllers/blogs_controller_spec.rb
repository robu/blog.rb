require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BlogsController do

  def mock_blog(stubs={})
    @mock_blog ||= mock_model(Blog, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all blogs as @blogs" do
      Blog.should_receive(:find).with(:all).and_return([mock_blog])
      get :index
      assigns[:blogs].should == [mock_blog]
    end

    describe "with mime type of xml" do
  
      it "should render all blogs as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Blog.should_receive(:find).with(:all).and_return(blogs = mock("Array of Blogs"))
        blogs.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested blog as @blog" do
      Blog.should_receive(:find).with("37").and_return(mock_blog)
      get :show, :id => "37"
      assigns[:blog].should equal(mock_blog)
    end
    
    describe "with mime type of xml" do

      it "should render the requested blog as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Blog.should_receive(:find).with("37").and_return(mock_blog)
        mock_blog.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new blog as @blog" do
      Blog.should_receive(:new).and_return(mock_blog)
      get :new
      assigns[:blog].should equal(mock_blog)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested blog as @blog" do
      Blog.should_receive(:find).with("37").and_return(mock_blog)
      get :edit, :id => "37"
      assigns[:blog].should equal(mock_blog)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created blog as @blog" do
        Blog.should_receive(:new).with({'these' => 'params'}).and_return(mock_blog(:save => true))
        post :create, :blog => {:these => 'params'}
        assigns(:blog).should equal(mock_blog)
      end

      it "should redirect to the created blog" do
        Blog.stub!(:new).and_return(mock_blog(:save => true))
        post :create, :blog => {}
        response.should redirect_to(blog_url(mock_blog))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved blog as @blog" do
        Blog.stub!(:new).with({'these' => 'params'}).and_return(mock_blog(:save => false))
        post :create, :blog => {:these => 'params'}
        assigns(:blog).should equal(mock_blog)
      end

      it "should re-render the 'new' template" do
        Blog.stub!(:new).and_return(mock_blog(:save => false))
        post :create, :blog => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested blog" do
        Blog.should_receive(:find).with("37").and_return(mock_blog)
        mock_blog.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :blog => {:these => 'params'}
      end

      it "should expose the requested blog as @blog" do
        Blog.stub!(:find).and_return(mock_blog(:update_attributes => true))
        put :update, :id => "1"
        assigns(:blog).should equal(mock_blog)
      end

      it "should redirect to the blog" do
        Blog.stub!(:find).and_return(mock_blog(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(blog_url(mock_blog))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested blog" do
        Blog.should_receive(:find).with("37").and_return(mock_blog)
        mock_blog.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :blog => {:these => 'params'}
      end

      it "should expose the blog as @blog" do
        Blog.stub!(:find).and_return(mock_blog(:update_attributes => false))
        put :update, :id => "1"
        assigns(:blog).should equal(mock_blog)
      end

      it "should re-render the 'edit' template" do
        Blog.stub!(:find).and_return(mock_blog(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested blog" do
      Blog.should_receive(:find).with("37").and_return(mock_blog)
      mock_blog.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the blogs list" do
      Blog.stub!(:find).and_return(mock_blog(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(blogs_url)
    end

  end

end
