# Methods added to this helper will be available to all templates in the application.
include ReCaptcha::ViewHelper
module ApplicationHelper
  def attached_image(content_image, options = {})
    image_tag(post_attachment_path(content_image.owner, content_image), 
      {
        :size => "#{content_image.width}x#{content_image.height}",
        :alt => content_image.alt_text
      }.merge(options))
  end
end
