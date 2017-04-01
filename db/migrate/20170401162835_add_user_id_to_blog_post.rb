class AddUserIdToBlogPost < ActiveRecord::Migration[5.0]
  def change
    remove_column :blog_posts, :asked_by_id
    add_reference :blog_posts, :user, foreign_key: true, index: true
  end
end
