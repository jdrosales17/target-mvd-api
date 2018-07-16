class ApplicationMailer < ActionMailer::Base
  default to: 'admin@targetmvd.com'
  layout 'mailer'

  def email_to_admin(email_from, subject, body)
    @body = body
    mail(from: email_from, subject: subject)
  end
end
