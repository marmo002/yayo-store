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
        # create ref num and expiration date
        ref_number = @admin.set_ref_code
        
        # save new admin
        @admin.save
        
        # send registration email to admin
        NotificationsMailer.with(
          reference_number: ref_number,
          admin_user: @admin.id
        ).registration_email.deliver_now

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
