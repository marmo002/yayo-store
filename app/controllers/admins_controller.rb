class AdminsController < ApplicationController
  before_action :require_admin
  before_action :only_super_admin
  layout "admin_layout"

  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.valid?
        
        # Set ref num and expiration date
        # and email it to admin user
        @admin.send_ref_code                        # send_ref_code will use set_ref_code which will save the instance 

        format.html {
          flash[:success] = "Se creo nuevo admin existosamente"
          redirect_to admins_path
        }
        format.json { render :show, status: :created, location: admins_path }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])

    respond_to do |format|
      if @admin.update(admin_params)
        format.html {
          flash[:success] = 'Se actualizo correctamente'
          redirect_to admins_path
        }
        format.json { render :show, status: :ok, location: admins_path }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def resend_ref_code
    # byebug
    admin = Admin.find(params[:id])
    if admin
      admin.send_ref_code
      render json: { success: true }
    else
      render status: 500
    end 
  end

  private

    def admin_params
      params.require(:admin).permit(
        :email,
        :admin_type
      )
    end

    def only_super_admin
      unless current_admin.super_admin?
        flash[:warning] = "No tienes permisos para ver esta pagina"
        redirect_to products_path
      end
    end

end
