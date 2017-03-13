FactoryGirl.define do
  factory :lesson do
    course
    weight 1
    name 'A lesson'
  end
end

# == Schema Information
#
# Table name: lessons
#
#  id         :integer          not null, primary key
#  name       :string
#  course_id  :integer
#  weight     :integer
#  slug       :string
#  free       :boolean          default("false")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_lessons_on_course_id             (course_id)
#  index_lessons_on_course_id_and_weight  (course_id,weight) UNIQUE
#
