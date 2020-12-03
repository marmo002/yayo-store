class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_admin
    @current_admin ||= Admin.where(id: session[:admin_id]).first if session[:admin_id]
  end

  def require_admin
    if current_admin.nil?
      flash[:warning] = "Porfavor inicia sesion."
      redirect_to login_path
    end
  end

end
