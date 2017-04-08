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

  def blog_post_answered(blog_post)
    @user = blog_post.user
    @blog_post = blog_post

    mail(
      to: %("#{@user.name}" <#{@user.email}>),
      subject: "Acabei de reponder sua pergunta!",
    )
  end

  def notify_admin_new_post(commentable)
    @commentable = commentable
    mail(
      from: 'SuperDev <noreply@superdev.academy>',
      to: %("Rafael Garcia" <rafael@superdev.academy>),
      subject: "Novo post",
    )
  end

  def ask_about_purchase_completion(email)
    @user = User.where(email: email).first

    logger.info ">>> #{email}"
    if @user.present?
      logger.info ">>> #{user.name}"
      mail(
        from: 'Rafael Garcia <rafael@superdev.academy>',
        to: %("#{@user.name}" <#{@user.email}>),
        subject: "Fala #{@user.first_name}! Posso te Perguntar uma coisa?",
      )
    end
  end

end
