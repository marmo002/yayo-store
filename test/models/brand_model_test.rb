require 'test_helper'

class BrandModelTest < ActiveSupport::TestCase

  def setup
    %w(brand1, brand2, brand3, brand4, brand5).each do |brand|
      Brand.create(name: brand)
    end
    @model_alt = BrandModel.new(name: "mODel001 iS heRE   ", brand: Brand.first)
  end

  def tear_down
    Brand.destroy_all
  end

  test "should not save brand_model without name and a brand" do
    @model = BrandModel.new()

    assert_not @model.save, "== Saved without name and brand"
  end

  test "should not save brand_model without name" do
    @model = BrandModel.new(brand: Brand.first)

    assert_not @model.save, "== Saved without name"
  end

  test "should not save brand_model without brand" do
    @model = BrandModel.new(name: "Model1")

    assert_not @model.save, "== Saved without brand"
  end

  test "name is unique" do
    model1 = BrandModel.create(name: "unique name", brand: Brand.last)
    model2 = BrandModel.new(name: "unique name", brand: Brand.first)

    assert_not model2.save ,"== Saved brand_model with already in used name"
  end

  test "name is propertly formatted" do
    @model_alt.save
    assert_equal "Model001 Is Here", @model_alt.name ,"== Saved brand_model name without proper formatting"
  end

end
