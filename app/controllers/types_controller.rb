class TypesController < ApplicationController
  layout "admin_layout"
  before_action :get_type, only: [:edit, :update]


  def index
    @types = Type.all
  end

  def new
    @type = Type.new
  end

  def edit

  end

  def create
    @type = Type.new(type_params)

    respond_to do |format|
      if @type.save
        format.html { redirect_to types_path, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @type }
      else
        format.html { render :new }
        format.json { render json: @type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @type.update(type_params)
        format.html { redirect_to types_path, notice: 'Se actualizo correctamente' }
        format.json { render :show, status: :ok, location: @type }
      else
        format.html { render :edit }
        format.json { render json: @type.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def get_type
    @type = Type.find(params[:id])
  end

  def type_params
    params.require(:type).permit(:name)
  end


end
