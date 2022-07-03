class ApplicationMailer < ActionMailer::Base
  default from: Figaro.env.email_username
  layout "mailer"
end
