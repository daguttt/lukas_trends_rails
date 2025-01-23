class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def prueba
    puts 'SE ENVIA CORREO'
    UserMailer.welcome_email.deliver_now
  end

  def imprimir
    puts "hola"
  end
end
