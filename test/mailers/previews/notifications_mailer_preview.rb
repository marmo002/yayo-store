# Preview all emails at http://localhost:3000/rails/mailers/notifications_mailer
class NotificationsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notifications_mailer/registration_email
  def registration_email
    NotificationsMailer.with(reference_number: "654456asdfasd-098asd", admin_user: Admin.last.id).registration_email
  end

end
