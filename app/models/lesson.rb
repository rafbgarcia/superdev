class Lesson < ApplicationRecord
  # Relationships
    belongs_to :course
    has_many :items, -> { order(:weight) }

  # Validations
    validates_presence_of :weight, :name, :course

  # Scopes
    scope :by_course, -> { order(:course_id, :weight) }

  # Slug
    extend FriendlyId
    friendly_id :name, use: :slugged


  def to_s
    name
  end

end
