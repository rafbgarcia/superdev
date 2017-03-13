FactoryGirl.define do
  factory :user do
    name "John Doe"
    email "hey@jude.com"
    password "123456"
    level 1
    xp 0
  end
end

# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string           default(""), not null
#  encrypted_password      :string           default(""), not null
#  reset_password_token    :string
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  provider                :string
#  uid                     :string
#  name                    :string
#  gender                  :string
#  phone                   :string
#  facebook_link           :string
#  facebook_avatar         :string
#  avatar_file_name        :string
#  avatar_content_type     :string
#  avatar_file_size        :integer
#  avatar_updated_at       :datetime
#  guest                   :boolean          default("false")
#  level                   :integer          default("1")
#  xp                      :integer          default("0")
#  subscribed              :boolean          default("false")
#  subscription_expires_at :date
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
