class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  after_action :set_csrf_cookie_for_angular_xhr_requests

  def acme_challenge
    render text: 'LJvIFUW0yHXTNEGGr6YPwdRt8HxPB2UK7ZLKmW3w5IQ.BALPitwZqtD4Fya9BP5w6jnmDZlP6S0iYEuXkZjoY9k'
  end

protected

  def set_csrf_cookie_for_angular_xhr_requests
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

end
