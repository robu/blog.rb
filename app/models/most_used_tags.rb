class MostUsedTags < SidebarComponent
  def tags
    self.blog.tags
  end

  def content
    html = ""
    for tag in tags
      html << "<div class=\"sidebar_tag\">#{ tag.name }</div>\n"
    end
    html
  end
end

