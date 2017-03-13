class Course < ApplicationRecord
  has_many :lessons, -> { order(:weight) }

  # Slug
    extend FriendlyId
    friendly_id :name, use: :slugged

  # Paperclip
    has_attached_file :image, path: "/courses-images/:id-:style.:extension"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/


  def to_s
    name
  end

end
