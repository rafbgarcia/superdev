class CreatePostComments < ActiveRecord::Migration[5.0]
  def change
    create_table :post_comments do |t|
      t.text :text
      t.belongs_to :user, foreign_key: true
      t.belongs_to :blog_post, foreign_key: true
      t.integer :votes

      t.timestamps
    end
  end
end
