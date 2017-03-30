class BlogPost < ApplicationRecord
  include AASM
  belongs_to :asked_by, class_name: 'User'
  # Slug
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Scopes
  scope :published, -> { where('posted_at <= ?', Time.now) }

  validates_presence_of :title
  accepts_nested_attributes_for :asked_by


  def belongs_to?(user)
    return false if self.asked_by.blank?
    self.asked_by.id == user.id
  end

  aasm do
    state :pending_approval, initial: true
    state :approved
    state :rejected

    event :approve { transitions from: :pending_approval, to: :approved }
    event :reject { transitions from: :pending_approval, to: :rejected }
  end

end
