class SizesController < ApplicationController
  before_action :get_size, only: [:show, :edit, :update, :destroy]

  layout "admin_layout"

  def index
    @sizes = Size.all
  end

  def new
    @size = Size.new
  end

  def create
    @size = Size.new(size_params)

    respond_to do |format|
      if @size.save
        format.html {
          flash[:success] = "Talla #{@size.name} se creo existosamente"
          redirect_to sizes_path
        }
        format.json { render :show, status: :created, location: @size }
      else
        format.html { render :new }
        format.json { render json: @size.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def update

    respond_to do |format|
      if @size.update(size_params)
        format.html {
          flash[:success] = 'Se actualizo correctamente'
          redirect_to sizes_path
        }
        format.json { render :show, status: :ok, location: @size }
      else
        format.html { render :edit }
        format.json { render json: @size.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def get_size
      @size = Size.find(params[:id])
    end

    def size_params
      params.require(:size).permit(:name)
    end

end
