class AdminSessionsController < ApplicationController
  layout "admin_registrations"

  def new
    # If current_admin_user, redirect to dashboard
    # message: "Tu sesion esta abierta"
  end

  def create
    admin = Admin.find_by(email: params[:email])
    # byebug
    if admin && admin.registered? # Acceso negado. Contacta a tu administrador
      # Check authentication
      if admin.authenticate(params[:password])
        # session[:admin_id] = admin.id
        flash[:primary] = "Se inicio sesion de manera exitosa!"

        redirect_to products_path

      else
        # flash[:danger] = "Email o contraseña incorrectos."
        flash[:danger] = "Wrong password."
        redirect_to login_path
      end
    else
      # flash[:danger] = "Email o contraseña incorrectos."
      flash[:danger] = "Email/status error."
      redirect_to login_path
    end
  end

  def destroy
  end
end
