class ApplicationMailer < ActionMailer::Base
  default from: %("Rafael Garcia" <rafael@superdev.com.br>)
  layout 'mailer'
end
