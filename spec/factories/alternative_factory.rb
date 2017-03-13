FactoryGirl.define do
  factory :alternative do
    text 'An alternative'
    correct true
    explanation 'Treta'
  end
end

# == Schema Information
#
# Table name: alternatives
#
#  id                 :integer          not null, primary key
#  choice_question_id :integer
#  text               :text
#  correct            :boolean
#  explanation        :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_alternatives_on_choice_question_id  (choice_question_id)
#
