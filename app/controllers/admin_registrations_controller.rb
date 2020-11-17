class AdminRegistrationsController < ApplicationController

  def new
    @admin_registration = AdminRegistration.new
  end

  def create
    @admin_registration = AdminRegistration.new(admin_registration_params)

    if @admin_registration.valid?
      user_auth = UserAuthentication.new(@admin_registration)

      if user_auth.authenticate
        # session is created: Session[registrating_admin_id] = ID
        session[:registrating_admin_id] = user_auth.user.id
        redirect_to registration_path
      else
        # byebug
        flash[:danger] = user_auth.message
        redirect_back(fallback_location: authenticate_path)
      end

    else
      render :new
    end

  end

  def edit
    @admin = Admin.find(session[:registrating_admin_id])
  end

  def update
    # code
  end

  private

    def admin_registration_params
      params.require(:admin_registration).permit(
        :email,
        :reference_code
      )
    end
end
