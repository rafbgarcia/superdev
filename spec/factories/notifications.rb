FactoryGirl.define do
  factory :notification do
    user nil
    seen false
    notificable nil
  end
end

# == Schema Information
#
# Table name: notifications
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  notificable_id   :integer
#  notificable_type :string
#  seen             :boolean          default("false")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_notifications_on_user_id  (user_id)
#
