class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_admin
  
  def current_admin
    @current_admin ||= Admin.where(id: session[:admin_id]).first if session[:admin_id]
  end

  def logged_admin
    if current_admin && current_admin.registered?
      flash[:warning] = "Ya has iniciado sesion!"
      redirect_to products_path
      return
    end
  end

  def require_admin
    if current_admin.nil?
      flash[:warning] = "Porfavor inicia sesion."
      redirect_to login_path
    elsif !current_admin.registered?
      session[:admin_id] = nil
      flash[:warning] = "Tu estado ha sido reseteado. Revisa tu email o contacta a tu administrador."
      redirect_to login_path
    end
  end

end
