class CodeQuestion < ApplicationRecord
  has_one :item, as: :itemable, dependent: :destroy

  validates_presence_of :item, :language, :expected_answer

  accepts_nested_attributes_for :item
end
