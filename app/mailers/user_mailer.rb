class UserMailer < ApplicationMailer
  default from: 'laslukastrends@gmail.com' # Sender email address

  def welcome_email(user, message)
    @currencies = message

    mail(
      to: user["email"],
      subject: 'Daily Currency Update'
    ) do |format|
      format.html # Render the HTML template
    end
  end
end
