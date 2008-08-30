class LatestComments < SidebarComponent
  def comments
    comments = self.blog.latest_comments(3)
  end
  
  
  def content
    html = ""
    for comment in comments
      html << "<div class=\"sidebar_comment\">#{ comment.body_cleaned }</div>\n"
    end
    html
  end
end

