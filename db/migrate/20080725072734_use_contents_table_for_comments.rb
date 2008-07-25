class Content < ActiveRecord::Base; end

class UseContentsTableForComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :content_id, :integer
    Comment.all.each do |comment|
      c = Content.create :target => (comment.body_html || comment.body_source), :source_type => "redcloth"
      comment.content = c
      comment.save!
    end
    remove_column :comments, :body_source
    remove_column :comments, :body_html
  end

  def self.down
  end
end
