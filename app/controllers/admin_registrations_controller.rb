class AdminRegistrationsController < ApplicationController
  before_action :set_admin, only: [:edit, :update]
  before_action :logged_admin, only: [:new]


  def new
    # If current_admin_user, redirect to dashboard
    # message: "Tu sesion esta abierta"
    @admin_registration = AdminRegistration.new
  end

  def create
    @admin_registration = AdminRegistration.new(admin_registration_params)

    if @admin_registration.valid?
      options = {
        email:      @admin_registration.email,
        ref_code:   @admin_registration.reference_code,
        status_method: "pre_registered?"
      }
      user_auth = UserAuthentication.new( options )
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
        @admin.register_user
        # unset session variable
        session[:registrating_admin_id] = nil
        # Send email notification to admin user

        format.html {
          flash[:success] = 'Registracion completa. Por favor inicia session'
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
