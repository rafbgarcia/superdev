FactoryGirl.define do
  factory :answer do
    user
    alternative
    item
  end
end

# == Schema Information
#
# Table name: answers
#
#  id             :integer          not null, primary key
#  item_id        :integer          not null
#  user_id        :integer          not null
#  alternative_id :integer          not null
#  correct        :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_answers_on_alternative_id       (alternative_id)
#  index_answers_on_item_id              (item_id)
#  index_answers_on_item_id_and_user_id  (item_id,user_id) UNIQUE
#  index_answers_on_user_id              (user_id)
#
