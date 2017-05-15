class Project < ApplicationRecord
  has_many :courses

  # Paperclip
    has_attached_file :image, path: "/projects-images/:id-:style.:extension"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  # Scopes
    scope :by_weight, -> { order(:weight) }

end
