class MostUsedTags < SidebarComponent
  def tags(limit=0)
    tags = self.blog.tags
    tags.sort {|t1,t2| diff = t2.taggings.count <=> t1.taggings.count; diff != 0 ? diff : t1.name <=> t2.name}
    limit <= 0 || limit > tags.size ? tags : tags[0..(limit-1)]
  end

  def content
    html = ""
    for tag in tags
      html << "<div class=\"sidebar_tag\">#{ tag.name }</div>\n"
    end
    html
  end
end

