class IuguController < ActionController::API
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
    if params['event'].blank?
      head 200
      return
    end

    Iugu.api_key = ENV['IUGU_API_KEY'] || "30e045b8172796b804714c8423be3d9e"

    if params['data']['status'] == 'paid'
      begin
        subscription = Iugu::Subscription.fetch(params['data']['subscription_id'])
        User.activate_subscription!(subscription)
      rescue Iugu::ObjectNotFound
        head 404
        return
      end
    end

    head 200
  end

end
