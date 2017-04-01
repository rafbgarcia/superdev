class RenameBlogPostBodyToText < ActiveRecord::Migration[5.0]
  def change
    rename_column :blog_posts, :body, :text
  end
end
