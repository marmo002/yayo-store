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
    # Set user
    set_user

    # check if user exists
    # Check user status
    # authenticate_user
    # Check if ref_codeis valid
    ['user_exists?', 'check_user_status', 'authenticate_user', 'ref_code_expired?'].each do |method|
      break unless send(method)
    end

    @message ? false : true

  end # END OF AUTHENTICATION METHOD

  def error_message(message)
    @message = message
    false
  end

  private

  def set_user
    if @email.present?
      @user = Admin.find_by(email: @email)
    end
  end

  def user_exists?
    user.nil? ? error_message("Credenciales proporsionadas no son correctas") : true
  end

  def check_user_status
    user.send(@status_method) ? true : error_message("No tienes acceso. Contacta al administrador")
  end

  # Check if ref_code or password are accuarate
  def authenticate_user
    if @password # if options[:password]
      if user.authenticate(@password)
        return true
      else
        # Reduce admin login_attempts -1
        user.reduce_attempts

        # Send user no authorized message
        return error_message("Error en email o password. Intentos limitados")
      end
    else # if options[:ref_code]
      if user.authenticate_ref_code(@ref_code)
        return true
      else
        # Reduce admin login_attempts -1
        user.reduce_attempts

        # Send user no authorized message
        return error_message("Error en credenciales. Intentos limitados")
      end
    end
  end

  # If ref_code:
  # check if ref_code is still valid
  def ref_code_expired?
    return if @ref_code.nil?
    user.ref_code_still_valid? ? true : error_message("Codigo ha expirado. Contactar Administrador")
  end

end
