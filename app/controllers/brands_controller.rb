class BrandsController < ApplicationController
  layout "admin_layout"
  before_action :require_admin
  before_action :get_brand, only: [:edit, :update, :destroy]


  def index
    @brands = Brand.all

  end

  def new
    @brand = Brand.new
  end

  def edit

  end

  def create
    @brand = Brand.new(brand_params)

    respond_to do |format|
      if @brand.save
        format.html {
          flash[:success] = "Marca #{@brand.name} se creo existosamente"
          redirect_to brands_path
        }
        format.json { render :show, status: :created, location: @brand }
      else
        format.html { render :new }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @brand.update(brand_params)
        format.html {
          flash[:success] = 'Se actualizo correctamente'
          redirect_to brands_path
        }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :edit }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @brand.brand_models.count > 0
      # return user to previous page
      # with message
      flash[:danger] = "#{@brand.name} tiene modelos associados. No se puede eliminar"
      redirect_back(fallback_location: root_path)
      return
    end

    @brand.destroy
    respond_to do |format|
      format.html {
        flash[:success] = 'Brand was successfully destroyed.'
        redirect_to brands_url
      }
      format.json { head :no_content }
    end
  end

  private

  def get_brand
    @brand = Brand.find(params[:id])
  end

  def brand_params
    params.require(:brand).permit(:name, :logo)
  end

end
