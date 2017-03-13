FactoryGirl.define do
  factory :comment do
    user
    discussion
    text "MyText"
    upvotes 1
  end
end

# == Schema Information
#
# Table name: comments
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  discussion_id :integer
#  text          :text
#  upvotes       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_comments_on_discussion_id  (discussion_id)
#  index_comments_on_user_id        (user_id)
#
