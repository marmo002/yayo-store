require 'test_helper'

class BrandTest < ActiveSupport::TestCase
    def setup
      @new = Brand.new
      @brand = Brand.create(name: "AdiDas")
      @brand2 = Brand.create(name: "uNder arMOUr  ")
      @model = BrandModel.create(name: "Model1", brand: @brand)
      @model2 = BrandModel.create(name: "Model2", brand: @brand2)
    end

    def tear_down
      Brand.destroy_all
      BrandModel.destroy_all
    end

    test "should not save type without name" do
      assert_not @new.save, "== Saved type without title"
    end

    test "name is uniq" do
      @new.name = "aDidAs"
      assert_not @new.save, "== Saved type with name already used before"
    end

    test "name is propertly formatted" do
      assert_equal "Under Armour", @brand2.name ,"== Saved type name without proper formatting"
    end

    #brand models
    test "brand.models should be a collection" do
      assert_not_empty @brand.brand_models, "== Brand model collection was empty"
    end

    test "brand_model object should be in brand collection" do
      assert_includes @brand2.brand_models, @model2, "== Brand model no found in collection"
    end

end
