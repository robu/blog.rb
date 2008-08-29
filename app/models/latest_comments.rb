class LatestComments < SidebarComponent
  
  def content
    comments = self.blog.latest_comments
    html = ""
    for comment in comments
      html << "<div class=\"sidebar_comment\">#{ comment.body_cleaned }</div>\n"
    end
    html
  end
end

