class UserMailer < ApplicationMailer
  helper :application

  def payment_approved(user, new_password)
    @user = user
    @new_password = new_password

    mail(
      to: %("#{@user.name}" <#{@user.email}>),
      subject: "[SuperDev] Pagamento aprovado!",
    )
  end

  def new_comment(user, comment)
    @user = user
    @comment = comment
    mail(
      from: 'SuperDev <noreply@superdev.academy>',
      to: %("#{@user.name}" <#{@user.email}>),
      subject: "Novo comentário",
    )
  end

  def notify_admin(discussion)
    @discussion = discussion
    mail(
      from: 'SuperDev <noreply@superdev.academy>',
      to: %("Rafael Garcia" <rafael@superdev.academy>),
      subject: "Nova discussão",
    )
  end

end
