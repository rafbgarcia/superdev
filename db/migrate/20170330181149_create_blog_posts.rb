class CreateBlogPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.string :slug, unique: true
      t.text :body
      t.datetime :posted_at
      t.string :asked_by_id, foreign_key: true
      t.string :aasm_state, default: 'pending_approval'

      t.timestamps
    end
  end
end
