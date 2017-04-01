class BlogPost < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :comments, -> { order(created_at: :desc) }, as: :commentable

  # Slug
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Scopes
  scope :published, -> { includes(:user).where('posted_at <= ?', Time.now).order(posted_at: :desc) }

  validates_presence_of :title
  accepts_nested_attributes_for :user


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

end
