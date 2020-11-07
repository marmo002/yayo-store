require 'test_helper'

class TypeTest < ActiveSupport::TestCase

  test "should not save type without name" do
    type = Type.new
    assert_not type.save, "== Saved type without title"
  end

  test "name is uniq" do
    type1 = Type.create(name: "shorts")
    type2 = Type.new(name: "shoRts")
    assert_not type2.save, "== Saved type with name already used before"
  end

  test "name is capitalize" do
    type = Type.create(name: "shOrts sHort")

    assert_equal "Shorts Short", type.name ,"== Saved type name without proper formatting"
  end

end
