require 'test_helper'

class NotificationsMailerTest < ActionMailer::TestCase
  def setup
    @admin = Admin.create(email: "martin@gmail.com", admin_type: :admin)
    @ref_code = @admin.set_ref_code
  end

  def tear_down
    Admin.destroy_all
  end
  
  test "registration_email" do
    mail = NotificationsMailer.with(reference_number: "654456asdfasd-098asd", admin_user: @admin.id).registration_email
    assert_equal "Registra tu cuenta de Yayo Store", mail.subject
    assert_equal ["martin@gmail.com"], mail.to
    assert_match "Proceso de registro para cuenta administrador", mail.body.encoded
  end

end
