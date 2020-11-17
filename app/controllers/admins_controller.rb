class AdminsController < ApplicationController
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
      if @admin.save
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

end
