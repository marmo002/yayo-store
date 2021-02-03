class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_admin
  
  def current_admin
    @current_admin ||= Admin.where(id: session[:admin_id]).first if session[:admin_id]
  end

  # Method used in admin_registration_controller
  # and admins_sessions_controller. If user is already loggin
  # then user will be redirected to products page
  def logged_admin
    if current_admin
      flash[:warning] = "Ya has iniciado sesion!"
      redirect_to products_path
      return
    end
  end

  # require_admin is used to verified
  # that an admin users is logged in
  # and with status of registered.
  # Method is used on every controller of the admin dashboard
  def require_admin
    
    # if user is logged in,
    # verified if sessoin is not expired
    # and is status is registered
    if current_admin.nil?
      flash[:warning] = "Porfavor inicia sesion."
      redirect_to login_path
    elsif session[:session_created_at].nil? || ( session[:session_created_at] < 2.hours.ago )
      clear_session
      flash[:warning] = "Tu sesion ha expirado!"
      redirect_to login_path
    elsif !current_admin.registered?
      clear_session
      flash[:warning] = "Tu cuenta ha sido suspendida. Contacta a tu administrador."
      redirect_to login_path
    end

  end

  def clear_session
    reset_session
  end
end
