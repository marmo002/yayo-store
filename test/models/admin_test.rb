require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  def setup
    @admin = Admin.create(email: "mail@mail.com", admin_type: :admin)
    @ref_code = @admin.set_ref_code
  end

  def tear_down
    Admin.destroy_all
  end

  test "Admin can't be created without email" do
    admin = Admin.new(email: "")

    assert_not admin.save, "== Saved without email"
  end

  # This test will raise an ActiveRecord::RecordNotUnique
  # If model validation for uniq email are not set.
  # Model validations will run first, thus DB validations will not be reached
  test "Admin can't be created wiht existing email(ActiveRecordError)" do
    skip
    admin2 = Admin.new(email: "mail@mail.com", admin_type: :admin)

    assert_raises(ActiveRecord::RecordNotUnique) {
      admin2.save
    }
  end

  test "Admin can't be created wiht existing email(ModelValidations)" do
    admin2 = Admin.new(email: "mail@mail.com", admin_type: :admin)

    assert_not admin2.save, '== Saved admin with email already taken'
  end

  test "Admin can't be created without type" do
    admin = Admin.new(email: "mail@mail.com")

    assert_not admin.save, "== Saved without type"
  end

  test "Admin can't be updated without first or last name" do
    params = {email: "mail2@mail.com"}
    assert_not @admin.update(params), "== Updated without first_name or last_name"
  end

  test "Admin can't be updated without password" do
    params = {email: "mail2@mail.com", first_name: "John", last_name: "Doe", password_confirmation: "pass_test_01"}
    assert_not @admin.update(params), "== Updated without password"
  end

  test "Admin can't be updated if password_confirmation doesn't match" do
    params = {first_name: "John", last_name: "Doe", password: "pass_test_01", password_confirmation: "somthing else"}
    assert_not @admin.update(params), "== Updated without password_confirmation matching password"
  end

  test "Admin can't be updated if password is less than 6 chars" do
    params = {first_name: "John", last_name: "Doe", password: "pass5"}
    assert_not @admin.update(params), "== Updated admin with less than 6 chars password"
  end

  # Password format requirements:
  # One lower case letter
  # One upper case letter
  # One number between 0..9
  # Chars A-Z, a-z, 0-9
  # No special Characters ( ! # $ % & + - * ; : = ? @ _ | ~ ñ Ñ no_tildes)
  test "Admin can't be updated if password doesn't meet format requirements" do
    params = {first_name: "John", last_name: "Doe", password: "Password12á"}
    assert_not @admin.update(params), "== Updated admin with wrong password format"
  end

  test "whether admin ref_code is expired" do
    admin = Admin.find_by(email: 'mail@mail.com')

    assert @admin.ref_code_still_valid?, "== Admin ref code is expired"
  end

  test "Admin gets authenticated with ref_code" do

    assert_equal @admin, @admin.authenticate_ref_code(@ref_code), "== Did not authenticate with ref_code"
  end

  test "Admin gets authenticated with email and ref_code" do
    admin = Admin.find_by(email: 'mail@mail.com')

    assert_equal @admin, admin.authenticate_ref_code(@ref_code), "== Did not authenticate with email and ref_code"
  end

end
