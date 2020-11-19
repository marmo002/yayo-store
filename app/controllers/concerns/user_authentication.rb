class UserAuthentication

  attr_accessor :user, :message

  def initialize(options)
    @user = nil
    @message = nil
    @email = options[:email]
    @ref_code = options[:ref_code]
    @password = options[:password]
    @status_method = options[:status_method]
  end

  def authenticate
    # check if user exists
    user = Admin.find_by(email: @email)
    if user.nil?
      error_message("Wron email")
      return false
    end

    # Check user status
    unless user.send(@status_method)
      error_message("Wrong status for #{ @status_method }")
      return false
    end

    # Check if ref_code is accuarate
    if @password
      unless user.authenticate(@password)
        # Reduce admin login_attempts -1
        user.reduce_attempts
        # Send user no authorized message
        error_message "Error en email o password. Intentos limitados"
        return false
      end
    else
      unless user.authenticate_ref_code(@ref_code)
        # Reduce admin login_attempts -1
        user.reduce_attempts
        # Send user no authorized message
        error_message "Error en codigo. Intentos limitados"
        return false
      end
    end

    # Check if admin.ref_code_expiry is not expired
    unless user.ref_code_still_valid?
      # Send user to no authorized page
      error_message "Codigo ha expirado. Contactar Administrador"
      return false
    end

  end # End of authenticate method

  def error_message(message)
    @message = message
  end

end
