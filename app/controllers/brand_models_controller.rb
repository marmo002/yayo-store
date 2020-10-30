class BrandModelsController < ApplicationController
  layout "admin_layout"
  before_action :get_model, only: [:show, :edit, :update, :destroy]
  before_action :get_brands, only: [:new, :create, :edit, :update]


  def index
    @brand_models = BrandModel.all.includes(:brand)
  end

  def show

  end

  def new
    @brand_model = BrandModel.new
  end

  def edit

  end

  def create
    @brand_model = BrandModel.new(brand_model_params)

    respond_to do |format|
      if @brand_model.save
        format.html {
          flash[:success] = "Modelo #{@brand_model.name} se creo existosamente"
          redirect_to @brand_model
        }
        format.json { render :show, status: :created, location: @brand_model }
      else
        format.html { render :new }
        format.json { render json: @brand_model.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @brand_model.update(brand_model_params)
        format.html {
          flash[:success] = 'Se actualizo correctamente'
          redirect_to @brand_model
        }
        format.json { render :show, status: :ok, location: @brand_model }
      else
        format.html { render :edit }
        format.json { render json: @brand_model.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    @brand_model.destroy
    respond_to do |format|
      format.html {
        flash[:success] = 'Se borro satisfactoriamente.'
        redirect_to brand_models_url
      }
      format.json { head :no_content }
    end
  end

  private

  def get_model
    @brand_model = BrandModel.find(params[:id])
  end

  def get_brands
    @brands = Brand.all.map { |brand|
      [brand.name, brand.id]
    }
  end

  def brand_model_params
    params.require(:brand_model).permit(:name, :brand_id)
  end

end
