require 'rails_helper'

describe User, type: :model do
  describe 'self.activate_subscription' do

    it 'activates a subscription' do
      user = User.new(
        iugu_customer_id: '1',
        email: 'email@email.com',
        name: 'Rafa',
      )
      user.save!(validate: false)

      expect(User.first.iugu_customer_id).to eq '1'
      expect(User.first.iugu_subscription_id).to eq nil
      expect(User.first.has_active_subscription?).to eq false
      expect(User.first.iugu_subscription_expires_at).to be_nil
      expect(User.first.encrypted_password.size).to eq 0

      subscription = OpenStruct.new({
        id: '123',
        customer_id: '1',
        expires_at: '2017-04-17',
      })

      User.activate_subscription!(subscription)

      expect(User.first.iugu_customer_id).to eq '1'
      expect(User.first.iugu_subscription_id).to eq '123'
      expect(User.first.iugu_subscription_expires_at).to eq Date.parse('2017-04-17')
      expect(User.first.has_active_subscription?).to eq true
      expect(User.first.encrypted_password.size).to be > 0
    end
  end
end
