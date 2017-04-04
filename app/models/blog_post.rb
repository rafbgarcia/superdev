class BlogPost < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :comments, -> { order(created_at: :asc) }, as: :commentable

  # Slug
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  # Scopes
  scope :published, -> { includes(:user).where('posted_at <= ?', Time.now).order(posted_at: :desc) }

  validates_presence_of :title
  accepts_nested_attributes_for :user

  after_create :notify_admin


  def belongs_to?(user)
    return false if self.user.blank?
    self.user.id == user.id
  end

  aasm do
    state :pending_approval, initial: true
    state :approved
    state :rejected

    event :approve { transitions from: :pending_approval, to: :approved }
    event :reject { transitions from: :pending_approval, to: :rejected }
  end

private

  def slug_candidates
    [
      :title,
      [:title, :count_same_title],
    ]
  end

  def count_same_title
    BlogPost.where(title: title).count
  end

  def notify_admin
    Notification.new_post(self)
  end

end
