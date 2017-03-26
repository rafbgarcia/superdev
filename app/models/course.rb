class Course < ApplicationRecord
  has_many :lessons, -> { order(:weight) }

  # Slug
    extend FriendlyId
    friendly_id :name, use: :slugged

  # Paperclip
    has_attached_file :image, path: "/courses-images/:id-:style.:extension"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  # Scopes
    scope :by_weight, -> { order(:weight) }


  def previous_course
    Course.where('id < ?', self.id).limit(1).first
  end

  def next_course
    Course.where('id > ?', self.id).limit(1).first
  end


  def to_s
    name
  end

end
