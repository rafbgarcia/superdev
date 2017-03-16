require 'rails_helper'

describe User, type: :model do
  describe 'self.activate_subscription' do

    it 'activates a subscription' do
      create :user, iugu_customer_id: '1'

      expect(User.first.iugu_customer_id).to eq '1'
      expect(User.first.iugu_subscription_id).to eq nil
      expect(User.first.has_active_subscription).to eq false

      subscription = OpenStruct.new({
        customer_id: '1',
        id: '123'
      })

      User.activate_subscription!(subscription)

      expect(User.first.iugu_customer_id).to eq '1'
      expect(User.first.iugu_subscription_id).to eq '123'
      expect(User.first.has_active_subscription).to eq true
    end
  end
end
