class AdminRegistrationsController < ApplicationController
  before_action :set_admin, only: [:edit, :update]

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

  end

  def update

    respond_to do |format|
      if @admin.update(admin_params)
        # Change admin status
        # unset session variable
        # Send email notification to admin user
        format.html {
          flash[:success] = 'Te registraste correctamente'
          redirect_to login_path
        }
        format.json { render :show, status: :ok, location: login_path }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def admin_registration_params
      params.require(:admin_registration).permit(
        :email,
        :reference_code
      )
    end

    def admin_params
      params.require(:admin).permit(
        :first_name,
        :last_name,
        :password,
        :password_confirmation
      )
    end

    def set_admin
      if session[:registrating_admin_id]
        @admin = Admin.find(session[:registrating_admin_id])
      else
        flash[:danger] = "Debes autenticarte para ver esta pagina"
        redirect_to authenticate_path
      end
    end
end
