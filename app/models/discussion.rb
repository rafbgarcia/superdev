class Discussion < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_many :comments, -> { order(:created_at) }

  validates_presence_of :title, :text, :user, :item

  after_create :notify_new_discussion

  # Slug
    extend FriendlyId
    friendly_id :slug_candidates, use: :slugged


  def belongs_to?(user)
    self.user.id == user.id
  end

private

  def slug_candidates
    [
      :title,
      [:title, :count_same_title],
    ]
  end

  def count_same_title
    Discussion.where(title: title).count
  end

  def notify_new_discussion
    Notification.new_discussion(self)
  end

end
