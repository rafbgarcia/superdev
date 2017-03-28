class UsersController < ApplicationController
  before_action :authenticate_user!

  def dashboard
  end

  def update_profile
    if current_user.update(profile_params)
      redirect_to action: :profile
    else
      render :profile
    end
  end

  def update_password
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
