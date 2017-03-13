FactoryGirl.define do
  factory :item do
    title "Some title"
    lesson
    weight 1
    difficulty 1
    itemable_type ChoiceQuestion.name
  end
end

# == Schema Information
#
# Table name: items
#
#  id            :integer          not null, primary key
#  lesson_id     :integer
#  itemable_id   :integer
#  itemable_type :string
#  weight        :integer
#  title         :string
#  description   :text
#  difficulty    :integer          default("0")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_items_on_lesson_id             (lesson_id)
#  index_items_on_lesson_id_and_weight  (lesson_id,weight) UNIQUE
#
