class ApplicationMailer < ActionMailer::Base
  default to: 'admin@targetmvd.com'
  layout 'mailer'

  def email_to_admin(email_from, params)
    @body = params[:body]
    mail(from: email_from, subject: params[:subject])
  end
end
