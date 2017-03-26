class Lesson < ApplicationRecord
  # Relationships
    belongs_to :course
    has_many :items, -> { order(:weight) }

  # Validations
    validates_presence_of :name, :course

  # Scopes
    scope :by_course, -> { order(:course_id, :weight) }

  # Slug
    extend FriendlyId
    friendly_id :name, use: :slugged

  before_create :set_weight

  def previous_lesson
    Lesson.where(course_id: self.course_id, weight: self.weight - 1).first
  end

  def next_lesson
    Lesson.where(course_id: self.course_id, weight: self.weight + 1).first
  end

  def update_weight(new_weight)
    existing_lesson = Lesson.where(course_id: self.course.id, weight: new_weight).first

      Rails.logger.info '>>> ' + new_weight
    if existing_lesson.present?
      existing_lesson.update_attributes(weight: -1)

      self_weight = self.weight

      self.update_attributes(weight: new_weight)
      existing_lesson.update_attributes(weight: self_weight)
    else
      self.update_attributes(weight: new_weight)
    end
  end

  def to_s
    name
  end

private

  def set_weight
    self.weight = Lesson.where(course_id: self.course.id).order(:weight).last.weight + 1
  end

end
