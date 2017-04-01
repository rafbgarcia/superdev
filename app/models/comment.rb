class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :notifications, as: :notificable

  validates_presence_of :text, :user_id, :commentable_id

  after_create :notify_new_comment


  def belongs_to?(user)
    return false if user.blank?
    self.user.id == user.id
  end

  def from_discussion?
    self.commentable_type == 'Discussion'
  end

  def from_blog_post?
    self.commentable_type == 'BlogPost'
  end

private

  def notify_new_comment
    Notification.new_comment(self)
  end

end
