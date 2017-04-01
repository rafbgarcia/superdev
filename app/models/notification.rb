class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notificable, polymorphic: true

  def mark_as_seen
    self.seen = true
    save!
  end


  class << self

    def new_discussion(discussion)
      UserMailer.notify_admin(discussion).deliver_later
    end

    def new_comment(comment)
      users_with_comments = [comment.commentable.user_id]
      users_with_comments += comment.commentable.comments.map(&:user_id).compact.uniq

      users_to_notify = users_with_comments - [comment.user_id]

      users_with_comments.each do |user_id|
        UserMailer.new_comment(User.find(user_id), comment).deliver_later
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
