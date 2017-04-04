class AddTextToBlogPost < ActiveRecord::Migration[5.0]
  def change
    add_column :blog_posts, :question_text, :text
  end
end
