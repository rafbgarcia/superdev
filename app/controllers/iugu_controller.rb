class IuguController < ApplicationController
  # @see https://iugu.com/referencias/gatilhos

  # {
  #   "data": {
  #       "subscription_id": "F4115E5E28AE4CCA941FCCCCCABE9A0A",
  #       "status": "paid",
  #       "id": "1757E1D7FD5E410A9C563024250015BF",
  #       "account_id": "70CA234077134ED0BF2E0E46B0EDC36F"
  #   },
  #   "event": "invoice.status_changed"
  # }
  def status_changed
    if params['data']['status'] == 'paid'
      subscription = Iugu::Subscription.fetch('77C8C07177FD46448B5ED18C35DD91A4')
      User.activate_subscription_for(subscription.customer_id)
    end
  end

end
