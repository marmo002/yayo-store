class AdminRegistrationsController < ApplicationController

  def new
    @admin_registration = AdminRegistration.new
  end

  def create
    @admin_registration = AdminRegistration.new(admin_registration_params)

    respond_to do |format|
      if @admin_registration.valid?
        format.html {
          redirect_to registration_path
        }
        format.json { render :show, status: :created, location: admins_path }
      else
        format.html { render :new }
        format.json { render json: @admin_registration.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @admin = Admin.find(Session[registrating_admin_id])
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
