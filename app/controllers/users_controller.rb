class UsersController < ApplicationController
  before_action :authenticate_user!

  def dashboard
  end

  def update_profile
    if current_user.update(profile_params)
      redirect_to profile_users_path, notice: 'Dados alterados com sucesso'
    else
      render :profile
    end
  end

  def update_password
    # devise logs out the user when the password is changed
    # so we need to log in again... >_>

    if current_user.update(password_params)
      user = User.find(current_user.id)
      bypass_sign_in(user)
      redirect_to edit_password_users_path, notice: 'Senha alterada com sucesso'
    else
      render :edit_password
    end
  end

  def dashboard
  end

private

  def profile_params
    params.require(:user).permit(:name, :avatar)
  end

  def password_params
    params.require(:user).permit(:password)
  end

end
