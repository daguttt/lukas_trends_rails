class UserMailer < ApplicationMailer
  default from: 'laslukastrends@gmail.com' # Sender email address

  def welcome_email
    mail(
      to: 'santiagocherrys@hotmail.com',
      subject: 'Test Email from Hotmail SMTP',
      body: 'This is a test email to verify SMTP configuration with Hotmail.'
    )
  end
end
