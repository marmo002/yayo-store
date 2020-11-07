class ProductsController < ApplicationController
  before_action :get_product, only: [:show, :edit, :update, :destroy]
  before_action :set_others, only: [:new, :create, :edit, :update]
  layout "admin_layout"

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html {
          flash[:success] = "Se creo producto existosamente"
          redirect_to @product
        }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update

    respond_to do |format|
      if @product.update(product_params)
        format.html {
          flash[:success] = 'Se actualizo correctamente'
          redirect_to @product
        }
        format.json { render :show, status: :ok, location: products_path }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def get_product
      @product = Product.where(id: params[:id]).first
      unless @product
        flash[:danger] = "No hay acceso a esta pagina"
        redirect_back(fallback_location: products_path)
        return
      end
    end

    def set_others
      @types = Type.all.map { |type|
        [type.name, type.id]
      }
      @brands = Brand.all.map { |brand|
        [brand.name, brand.id]
      }
      @models = BrandModel.all.map { |model|
        [model.name, model.id]
      }
    end

    def product_params
      params.require(:product).permit(
        :status,
        :title,
        :type_id,
        :brand_id,
        :brand_model_id,
        :title,
        :gender,
        :description,
        :price,
        :sale_price,
        product_colors_attributes: [
          :_destroy, :color_id, :id, pictures: [],
          color_sizes_attributes: [ :_destroy, :size_id, :id, :stock ]
       ]
      )
    end

end
