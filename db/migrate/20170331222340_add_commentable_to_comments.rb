class AddCommentableToComments < ActiveRecord::Migration[5.0]
  def up
    add_reference :comments, :commentable, polymorphic: true, index: true
    Comment.all.each do |comment|
      comment.update_attributes(
        commentable_id: comment.discussion_id,
        commentable_type: 'Discussion',
      )
    end

    remove_column :comments, :discussion_id
  end

  def down
    change_table :comments do |t|
      t.belongs_to :discussion, index: true, foreign_key: true
    end

    Comment.all.each do |comment|
      comment.update_attributes(discussion_id: comment.commentable_id)
    end

    remove_reference :comments, :commentable
  end
end
