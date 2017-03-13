require 'rails_helper'

RSpec.describe Discussion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: discussions
#
#  id         :integer          not null, primary key
#  item_id    :integer
#  user_id    :integer
#  upvotes    :integer          default("0")
#  title      :string
#  text       :text
#  resolved   :boolean          default("false")
#  slug       :string
#  edited     :boolean          default("false")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_discussions_on_item_id  (item_id)
#  index_discussions_on_user_id  (user_id)
#
