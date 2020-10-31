require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @brand1 = Brand.create(name: "AdiDas")
    @brand2 = Brand.create(name: "Lacoste")
    @brand3 = Brand.create(name: "Nike")

    @type1 = Type.create(name: "Shoes")
    @type2 = Type.create(name: "Running shoes")
    @type3 = Type.create(name: "sandals")

    @model1 = BrandModel.create(name: "Brazil-87", brand: @brand1)
    @model2 = BrandModel.create(name: "AIRBOUND-78", brand: @brand2)

    @product1 = Product.new(description: "sOME DESCRiption here", brand: @brand1, type: @type1, price: 120, sale_price: 99.99)
  end

  def tear_down
    Brand.destroy_all
    Type.destroy_all
    BrandModel.destroy_all
    Product.destroy_all
  end

  test "can create product without model" do
    assert @product1.save, '== Didnt save, model missing'
  end

  test "brand_model association returns nil" do
    @product1.save

    assert_nil @product1.brand_model, '== Returned an object'
  end

  test "brand_model association returns brand_model object" do
    @product1.brand_model = @model1
    @product1.save

    assert_instance_of BrandModel, @product1.brand_model, '== Returned an object'
  end

  test "associates type object is equal to product.type object" do
    @product1.save
    assert_equal @type1, @product1.type, '== Not the same type object'
  end

  test "gender is one of the allow options" do

    assert_raises(ArgumentError) {
      @product1.gender = "something else"
    }

  end

  test "status is one of the allow options" do

    assert_raises(ArgumentError) {
      @product1.status = "something"
    }

  end

  test "price must be greater than cero" do
    skip
    @product1.price = -20
    @product1.valid?

    assert_raises(ArgumentError) {
    }

  end

end
