class ApplicationMailer < ActionMailer::Base
  default from: %("Rafael Garcia" <rafael@superdev.academy>)
  layout 'mailer'
end
