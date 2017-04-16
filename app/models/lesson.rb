class Lesson < ApplicationRecord
  # Relationships
    belongs_to :course
    has_many :items, -> { order(:weight) }

  # Validations
    validates_presence_of :name, :course

  # Scopes
    scope :by_weight, -> { order(:weight) }

  # Slug
    extend FriendlyId
    friendly_id :slug_candidates, use: :slugged

  before_save :set_weight, if: :need_new_weight?

  def previous_lesson
    lesson = course.lessons.where(weight: weight - 1).first
    return lesson if lesson.present?

    course.previous_course&.lessons&.first
  end

  def next_lesson
    lesson = course.lessons.where(weight: weight + 1).first
    return lesson if lesson.present?

    course.next_course&.lessons&.first
  end

  def update_weight(new_weight)
    existing_lesson = Lesson.where(course_id: self.course.id, weight: new_weight).first

    if existing_lesson.present?
      existing_lesson.update_attributes(weight: 999)

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
    current_weight = Lesson.where(course_id: self.course.id).order(:weight).last&.weight || 0
    self.weight = current_weight + 1
  end

  def need_new_weight?
    return true if self.new_record?
    Lesson
      .where(course_id: self.course_id, weight: self.weight)
      .where.not(id: self.id)
      .exists?
  end

  def slug_candidates
    [
      :name,
      [:name, :count_same_name],
    ]
  end

  def count_same_name
    Lesson.where(name: name).count
  end

end
