class ColorsController < ApplicationController
  before_action :require_admin
  layout "admin_layout"
  before_action :get_color, only: [:show, :edit, :update, :destroy]

  def index
    @colors = Color.all
  end

  def show

  end

  def new
    @color = Color.new
  end

  def edit

  end

  def create
    @color = Color.new(color_params)

    respond_to do |format|
      if @color.save
        format.html {
          flash[:success] = "Color \"#{@color.name}\" se creo existosamente"
          redirect_to @color
        }
        format.json { render :show, status: :created, location: @color }
      else
        format.html { render :new }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @color.update(color_params)
        format.html {
          flash[:success] = 'Se actualizo correctamente'
          redirect_to @color
        }
        format.json { render :show, status: :ok, location: @color }
      else
        format.html { render :edit }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def get_color
    @color = Color.find(params[:id])
  end

  def color_params
    params.require(:color).permit(:name, :hex)
  end
end
