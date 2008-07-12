xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title(@blog.name)
    xml.link("http://ruby.robu.se/")
    xml.description(@blog.description)
    xml.language('en-us')
      for post in @posts
        xml.item do
          xml.title(post.title)
          xml.description(post.body)      
          xml.author(post.users.map(&:full_name).to_sentence)               
          xml.pubDate(post.published_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
          xml.link(post_url(post))
          xml.guid(post_url(post))
        end
      end
  }
}
