class UserMailer < ApplicationMailer

  def new_subscription(user, password)
    @user = user

    mail(
      to: %("#{@user.name}" <#{@user.email}>),
      subject: "[SuperDev] Bem vindo, #{@user.first_name}!",
    )
  end

end
