class Video < ApplicationRecord
  has_one :item, as: :itemable, dependent: :destroy

  validates_presence_of :item

  accepts_nested_attributes_for :item
end
