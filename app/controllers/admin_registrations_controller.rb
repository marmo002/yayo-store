class AdminRegistrationsController < ApplicationController

  def new
    @admin_registration = AdminRegistration.new
  end

  def create
    @admin_registration = AdminRegistration.new(admin_registration_params)

    respond_to do |format|
      if @admin_registration.valid?
        # Check if email exists in Admin Table
        admin = Admin.find_by email: @admin_registration.email
        format.html {
          if admin && admin.pre_registered?
            # Check if admin.ref_code_expiry is not expired
            if admin.authenticate_ref_code(@admin_registration.reference_code)
              # Check if ref_code is accuarate
              if admin.ref_code_still_valid?
                # session is created: Session[registrating_admin_id] = ID
                session[:registrating_admin_id] = admin.id
                redirect_to registration_path
                return
              else
                # Send user to no authorized page
                flash[:danger] = "Codigo expirado. Contactar Administrador"
                redirect_back(fallback_location: authenticate_path)
                return
              end
            else
              # Reduce admin login_attempts -1
              admin.login_attempts -= 1
              if admin.login_attempts < 1
                admin.status = :suspended
                # Set up email notification to admin user: Your account has been suspended
              end
              admin.save(validate: false)
              # Send user no authorized message
              flash[:danger] = "Acceso negado. Porfavor contactar administrador( Nivel #{admin.login_attempts})."
              redirect_back(fallback_location: authenticate_path)
              return
            end
          else
            # Send user no authorized message
            flash[:danger] = "Acceso negado. Porfavor contactar administrador"
            redirect_back(fallback_location: authenticate_path)
            return
          end
        }
        format.json { render :show, status: :created, location: admins_path }
      else
        format.html { render :new }
        format.json { render json: @admin_registration.errors, status: :unprocessable_entity }
      end
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
