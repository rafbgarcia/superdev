class Users::SessionsController < Devise::SessionsController
  # before_filter :before_login, only: :create
  after_filter :after_login, only: :create

  # def before_login
  # end

  def after_login
    return if current_user.has_active_subscription?

    self.update_subscription_expiration
  end


  def update_subscription_expiration
    subscription = current_user.subscription
    return if subscription.blank?

    current_user.update(
      iugu_subscription_expires_at: subscription.expires_at
    )
  end

end
