FactoryGirl.define do
  factory :subscription do
    expires_at "2016-04-15"
    active false
    type ""
    user nil
  end
end

# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  expires_at :date
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_subscriptions_on_user_id  (user_id)
#
