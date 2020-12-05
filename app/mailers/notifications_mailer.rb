class NotificationsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications_mailer.registration_email.subject
  #
  default from: 'Yayo Store <no-reply@yayo.store>'

  def registration_email
    admin = Admin.find( params[:admin_user] )
    @reference_number = params[:reference_number]
    @expiry_date = admin.code_expires_in

    mail subject: "Registra tu cuenta de Yayo Store", to: admin.email
  end
end
