require 'test_helper'

class BrandTest < ActiveSupport::TestCase
    def setup
      @new1 = Brand.new
    end

    def tear_down
      @new1.destroy
    end

    test "should not save type without name" do
      assert_not @new1.save, "== Saved type without title"
    end

    test "name is uniq" do
      brand1 = Brand.create(name: "AdiDas")
      brand2 = Brand.new(name: "AdiDas")
      assert_not brand2.save, "== Saved type with name already used before"
    end

    test "name is propertly formatted" do
      brand = Brand.create(name: " undeR aRmour")
      assert_equal "Under Armour", brand.name ,"== Saved type name without proper formatting"
    end

end
