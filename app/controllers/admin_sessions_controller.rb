class AdminSessionsController < ApplicationController
  layout "admin_registrations"
  before_action :logged_admin, only: [:new]


  def new
    # If current_admin_user, redirect to dashboard
    # message: "Tu sesion esta abierta"
  end

  def create

    user_auth = UserAuthentication.new( {
      email:      params[:email],
      password:   params[:password],
      status_method: "registered?"
    } )

    # Check authentication
    if user_auth.authenticate # Acceso negado. Contacta a tu administrador
        session[:admin_id] = user_auth.user.id
        flash[:primary] = "Se inicio sesion exitosamente!"
        redirect_to products_path
    else
      flash[:danger] = "Email o contraseña incorrectos."
      # More detailed message:
      # flash[:danger] = user_auth.message
      redirect_to login_path
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to login_path
    flash[:primary] = "Has cerrado sesion exitosamente."
  end
end
