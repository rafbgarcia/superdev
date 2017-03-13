class Item < ApplicationRecord
  # Relationships
    belongs_to :itemable, polymorphic: true
    belongs_to :lesson
    has_many :discussions, -> { order(upvotes: :desc) }

  # Validation
    validates_presence_of :title, :lesson_id, :weight

  # Scopes
    scope :by_lesson, -> { order(:lesson_id, :weight) }


  def previous_item
    Item.where(lesson_id: lesson_id, weight: weight - 1).first
  end

  def next_item
    Item.where(lesson_id: lesson_id, weight: weight + 1).first
  end

  def has_next_item?
    next_item.present?
  end

  def has_previous_item?
    previous_item.present?
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
      where(lesson: lesson, weight: weight).first
    end
  end

end
