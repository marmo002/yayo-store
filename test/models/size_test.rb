require 'test_helper'

class SizeTest < ActiveSupport::TestCase
    test "should not save size without name" do
      size = Size.new
      assert_not size.save, "== Saved size without name"
    end

    test "name is uniq" do
      size1 = Size.create(name: "37")
      size2 = Size.new(name: "37")
      size2.valid?

      assert_equal "Talla ya existe!", size2.errors.messages[:name][0],"== Saved size with name already used before"
    end

    test "name is capitalize" do
      size = Size.create(name: "small")

      assert_equal "Small", size.name ,"== Saved type name without proper formatting"
    end
end
