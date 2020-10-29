class BrandsController < ApplicationController
  layout "admin_layout"
  before_action :get_brand, only: [:edit, :update]


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
        format.html { redirect_to brands_path, notice: 'Product was successfully created.' }
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
        format.html { redirect_to brands_path, notice: 'Se actualizo correctamente' }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :edit }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
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
