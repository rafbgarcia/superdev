class UserMailer < ApplicationMailer

  def send_login_data_email(user)
    @user = user
    mail(
      to: %("#{@user.name}" <#{@user.email}>),
      subject: "[SuperDev] Bem vindo, #{@user.first_name}!",
    )
  end

  def send_welcome_email(user)
    @user = user
    mail(
      to: %("#{@user.name}" <#{@user.email}>),
      subject: "[SuperDev] Bem vindo, #{@user.first_name}!",
    )
  end

end
