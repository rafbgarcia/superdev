require 'rails_helper'

RSpec.describe CodeQuestion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
