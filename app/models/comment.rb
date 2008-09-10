require 'cgi'

class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :content
  has_one :blog, :through => :post

  validates_presence_of :post_id
  validates_associated :post

  validates_presence_of :commenter_name
  validates_length_of :commenter_name, :maximum => 200
  
  validates_length_of :commenter_email, :maximum => 200, :allow_blank => true
  validates_length_of :commenter_url, :maximum => 250, :allow_blank => true
  
  validates_length_of :title, :maximum => 250, :allow_blank => true
#  validates_length_of :body_source, :maximum => 5000, :allow_blank => true

#  validates_presence_of :title, :unless => Proc.new {|comment| comment.body_source}, :message => " or body must be present"
#  validates_presence_of :body_source, :unless => Proc.new {|comment| comment.title}, :message => " or title must be present"
  
  named_scope :latest, lambda {|num| {:order => "created_at desc", :limit => num}}
  named_scope :for_blog, lambda {|blog| {:conditions => ""}}

  def body_cleaned
    return "" unless body
    str = html2text(body.to_s)
    str
  end
  
  def body
    content.target if content
  end

  def body=(text)
    if self.content
      self.content.source = text
      self.content.save!
    else
      self.content = Content.create! :source => text
    end
  end
  
  private
  def html2text(html)
    text = html.
      gsub(/(&nbsp;|\n|\s)+/im, ' ').squeeze(' ').strip.
      gsub(/<([^\s]+)[^>]*(src|href)=\s*(.?)([^>\s]*)\3[^>]*>\4<\/\1>/i, '\4')

    links = []
    linkregex = /<[^>]*(src|href)=\s*(.?)([^>\s]*)\2[^>]*>\s*/i
    while linkregex.match(text)
      links << $~[3]
      text.sub!(linkregex, "[#{links.size}]")
    end

    text = CGI.unescapeHTML(
      text.
        gsub(/<(script|style)[^>]*>.*<\/\1>/im, '').
        gsub(/<!--.*-->/m, '').
        gsub(/<hr(| [^>]*)>/i, "___\n").
        gsub(/<li(| [^>]*)>/i, "\n* ").
        gsub(/<blockquote(| [^>]*)>/i, '> ').
        gsub(/<(br)(| [^>]*)>/i, "\n").
        gsub(/<(\/h[\d]+|p)(| [^>]*)>/i, "\n\n").
        gsub(/<[^>]*>/, '')
    ).lstrip.gsub(/\n[ ]+/, "\n") + "\n"

    for i in (0...links.size).to_a
      text = text + "\n  [#{i+1}] <#{CGI.unescapeHTML(links[i])}>" unless links[i].nil?
    end
    links = nil
    text
  end
  
end
