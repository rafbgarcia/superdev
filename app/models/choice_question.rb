class ChoiceQuestion < ApplicationRecord
  has_many :alternatives, dependent: :destroy
  has_one :item, as: :itemable, dependent: :destroy

  validates_presence_of :item

  accepts_nested_attributes_for :item
  accepts_nested_attributes_for :alternatives, allow_destroy: true
end
