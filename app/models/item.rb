class Item < ApplicationRecord
  # Relationships
    belongs_to :itemable, polymorphic: true
    belongs_to :lesson
    has_many :discussions, -> { order(upvotes: :desc) }

  # Validation
    validates_presence_of :title, :lesson_id

  # Scopes
    # scope :by_lesson, -> { includes(:lesson).order('lessons.weight ASC, items.weight ASC') }
    scope :by_lesson, -> { order(:lesson_id, :weight) }

  before_create :set_weight


  def previous_item
    item = self.lesson.items.where(weight: weight - 1).first
    return item if item.present?

    self.lesson.previous_lesson&.items&.last
  end

  def next_item
    item = self.lesson.items.where(weight: weight + 1).first
    return item if item.present?

    self.lesson.next_lesson&.items&.first
  end

  def has_next_item?
    next_item.present?
  end

  def has_previous_item?
    previous_item.present?
  end

  def update_weight(new_weight)
    existing_item = Item.where(lesson_id: self.lesson.id, weight: new_weight).first

    if existing_item.present?
      existing_item.update_attributes(weight: 999)

      self_weight = self.weight

      self.update_attributes(weight: new_weight)
      existing_item.update_attributes(weight: self_weight)
    else
      self.update_attributes(weight: new_weight)
    end
  end

  # Types

    def type
      itemable_type
    end

    def video?
      type == Video.name
    end

    def choice_question?
      type == ChoiceQuestion.name
    end


  class << self
    def for(lesson, weight)
      includes(discussions: [:item, :user]).where(lesson: lesson, weight: weight).first
    end
  end

private

  def set_weight
    self.weight = Item.where(lesson_id: self.lesson.id).order(:weight).last.weight + 1
  end

end
