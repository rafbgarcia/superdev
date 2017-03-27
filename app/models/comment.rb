class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :discussion
  has_many :notifications, as: :notificable

  validates_presence_of :text, :user_id, :discussion_id

  after_create :notify_new_comment

private

  def notify_new_comment
    Notification.new_comment(self)
  end

end
