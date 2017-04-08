class UserMailer < ApplicationMailer
  helper :application

  def notify_bounce(json)
    @commentable = commentable

    mail(
      from: 'SuperDev <noreply@superdev.academy>',
      to: %("Rafael Garcia" <rafael@superdev.academy>),
      subject: "Email Bounce",
      body: json
    )
  end

end
