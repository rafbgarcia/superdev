class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    if !user_provided_email?
      ask_for_email_again
      return
    end

    current_user.become_a_registered_user(request.env["omniauth.auth"])
    UserMailer.send_welcome_email(current_user).deliver_later

    # When a user have the password updated, warden signs him out by default.
    # That's why we have to bypass warden's callbacks in here.
    # More info at: https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-edit-their-password
    sign_in(current_user, bypass: true)

    redirect_to root_path
  end

  def failure
    flash[:alert] = 'Algo deu errado na tentative de Login, por favor tente novamente'
    redirect_to root_path
  end

private

  def user_provided_email?
    request.env["omniauth.auth"].info.email.present?
  end

  def ask_for_email_again
    redirect_to user_omniauth_authorize_path(provider: :facebook, auth_type: :rerequest, scope: :email)
  end

end
