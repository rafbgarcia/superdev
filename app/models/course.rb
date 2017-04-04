class Course < ApplicationRecord
  has_many :lessons, -> { order(:weight) }

  # Slug
    extend FriendlyId
    friendly_id :slug_candidates, use: :slugged

  # Paperclip
    has_attached_file :image, path: "/courses-images/:id-:style.:extension"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  # Scopes
    scope :by_weight, -> { order(:weight) }
    scope :visible, -> { where(visible: true) }


  def previous_course
    Course.where('id < ?', self.id).limit(1).first
  end

  def next_course
    Course.where('id > ?', self.id).limit(1).first
  end

  def available?
    Time.now > available_at
  end

  def show_available_at?
    (Time.now + 10.days) > available_at
  end

  def to_s
    name
  end

private

  def slug_candidates
    [
      :name,
      [:name, :count_same_name],
    ]
  end

  def count_same_name
    Course.where(name: name).count
  end
end
