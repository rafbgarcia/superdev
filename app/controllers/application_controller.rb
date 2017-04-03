class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception, prepend: true

  # after_action :set_csrf_cookie_for_angular_xhr_requests
  after_action :clear_flash
  after_action :log_user

  def acme_challenge
    render text: 'LJvIFUW0yHXTNEGGr6YPwdRt8HxPB2UK7ZLKmW3w5IQ.BALPitwZqtD4Fya9BP5w6jnmDZlP6S0iYEuXkZjoY9k'
  end

protected

  # def set_csrf_cookie_for_angular_xhr_requests
  #   cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  # end

  def require_subscription
    if !user_signed_in? || !current_user.has_active_subscription?
      render 'users/needs_subscription'
    end
  end

  # This clears flash after login and logout, it was showing up on weird scenarios:
  # - After user login and access his dashboard
  # - After user logout and access login page
  def clear_flash
    flash.clear
  end

  def log_user
    if user_signed_in?
      Rails.logger.info ">>> Usuário: #{current_user.name} <#{current_user.email}>"
    end
  end


end
