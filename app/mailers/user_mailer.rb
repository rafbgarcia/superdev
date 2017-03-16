class UserMailer < ApplicationMailer

  def payment_approved(user, new_password)
    @user = user
    @new_password = new_password

    mail(
      to: %("#{@user.name}" <#{@user.email}>),
      subject: "[SuperDev] Pagamento aprovado!",
    )
  end

end
