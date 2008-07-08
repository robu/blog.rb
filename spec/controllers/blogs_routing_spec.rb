require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BlogsController do
  describe "route generation" do

    it "should map { :controller => 'blogs', :action => 'index' } to /blogs" do
      route_for(:controller => "blogs", :action => "index").should == "/blogs"
    end
  
    it "should map { :controller => 'blogs', :action => 'new' } to /blogs/new" do
      route_for(:controller => "blogs", :action => "new").should == "/blogs/new"
    end
  
    it "should map { :controller => 'blogs', :action => 'show', :id => 1 } to /blogs/1" do
      route_for(:controller => "blogs", :action => "show", :id => 1).should == "/blogs/1"
    end
  
    it "should map { :controller => 'blogs', :action => 'edit', :id => 1 } to /blogs/1/edit" do
      route_for(:controller => "blogs", :action => "edit", :id => 1).should == "/blogs/1/edit"
    end
  
    it "should map { :controller => 'blogs', :action => 'update', :id => 1} to /blogs/1" do
      route_for(:controller => "blogs", :action => "update", :id => 1).should == "/blogs/1"
    end
  
    it "should map { :controller => 'blogs', :action => 'destroy', :id => 1} to /blogs/1" do
      route_for(:controller => "blogs", :action => "destroy", :id => 1).should == "/blogs/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'blogs', action => 'index' } from GET /blogs" do
      params_from(:get, "/blogs").should == {:controller => "blogs", :action => "index"}
    end
  
    it "should generate params { :controller => 'blogs', action => 'new' } from GET /blogs/new" do
      params_from(:get, "/blogs/new").should == {:controller => "blogs", :action => "new"}
    end
  
    it "should generate params { :controller => 'blogs', action => 'create' } from POST /blogs" do
      params_from(:post, "/blogs").should == {:controller => "blogs", :action => "create"}
    end
  
    it "should generate params { :controller => 'blogs', action => 'show', id => '1' } from GET /blogs/1" do
      params_from(:get, "/blogs/1").should == {:controller => "blogs", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'blogs', action => 'edit', id => '1' } from GET /blogs/1;edit" do
      params_from(:get, "/blogs/1/edit").should == {:controller => "blogs", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'blogs', action => 'update', id => '1' } from PUT /blogs/1" do
      params_from(:put, "/blogs/1").should == {:controller => "blogs", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'blogs', action => 'destroy', id => '1' } from DELETE /blogs/1" do
      params_from(:delete, "/blogs/1").should == {:controller => "blogs", :action => "destroy", :id => "1"}
    end
  end
end
