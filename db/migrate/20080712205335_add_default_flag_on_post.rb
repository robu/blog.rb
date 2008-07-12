class AddDefaultFlagOnPost < ActiveRecord::Migration
  def self.up
    add_column :blogs, :default_blog, :boolean, :default => false
  end

  def self.down
    remove_column :blogs, :default_blog
  end
end
