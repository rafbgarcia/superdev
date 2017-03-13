class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notificable, polymorphic: true

  def mark_as_seen
    self.seen = true
    save!
  end


  class << self

    def create_for_comment!(comment)
      return if comment.user_id == comment.discussion.user_id

      create!(
        user_id: comment.discussion.user_id,
        notificable: comment,
      )
    end

  end
end
