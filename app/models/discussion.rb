class Discussion < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_many :comments, -> { order(:created_at) }

  validates_presence_of :title, :text, :user, :item

  # Slug
    extend FriendlyId
    friendly_id :slug_candidates, use: :slugged


private

  def slug_candidates
    # This is used in case of repeated slugs
    [
      :title,
      [:title, :count_same_title],
    ]
  end

  def count_same_title
    Discussion.where(title: title).count
  end

end
