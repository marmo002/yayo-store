class UserAuthentication

  attr_accessor :admin_registration, :message, :user

  def initialize(admin_registration_object)
    @admin_registration = admin_registration_object
    @user = Admin.find_by email: admin_registration_object.email
    @message = nil
  end

  def authenticate
    # Check if email exists in Admin Table
    if user && user.pre_registered?
      # Check if ref_code is accuarate
      if user.authenticate_ref_code(@admin_registration.reference_code)
        # Check if admin.ref_code_expiry is not expired
        if user.ref_code_still_valid?
          # return authenticated user
          return true
        else
          # Send user to no authorized page
          error_message "Codigo ha expirado. Contactar Administrador"
        end
      else
        # Reduce admin login_attempts -1
        user.reduce_attempts
        # Send user no authorized message
        error_message "Error en codigo. Intentos limitados"
      end
    else
      # Send user no authorized message
      error_message "Acceso negado. Porfavor contactar administrador"
    end

  end # End of authenticate method

  def error_message(message)
    @message = message
    return false
  end

end
