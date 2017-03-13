FactoryGirl.define do
  factory :code_question do
    initial_code "MyText"
    expected_answer "MyText"
  end
end

# == Schema Information
#
# Table name: code_questions
#
#  id              :integer          not null, primary key
#  initial_code    :text
#  expected_answer :text
#  language        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
