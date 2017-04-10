class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notificable, polymorphic: true

  def mark_as_seen
    self.seen = true
    save!
  end


  class << self

    def new_post(commentable)
      UserMailer.notify_admin_new_post(commentable).deliver_later
    end

    def new_comment(comment)
      admin = User.admin&.id
      post_owner = comment.commentable.user_id

      users_with_comments = (
        [admin, post_owner] + comment.commentable.comments.map(&:user_id)
      ).compact.uniq

      # remove user who made the comment
      users_to_notify = users_with_comments - [comment.user_id]

      users_to_notify.each do |user_id|
        UserMailer.new_comment(user_id, comment.id).deliver_later
      end
    end

    def blog_post_answered(blog_post)
      if blog_post.user.present?
        UserMailer.blog_post_answered(blog_post).deliver_later
      end
    end

    def create_for_comment!(comment)
      return if comment.user_id == comment.commentable.user_id

      create!(
        user_id: comment.commentable.user_id,
        notificable: comment,
      )
    end

  end
end
