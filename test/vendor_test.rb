require './lib/vendor'
require 'minitest/autorun'
require 'minitest/pride'

class VendorTest < Minitest::Test
  def test_it_exists
    vendor = Vendor.new("name")

    assert_instance_of Vendor, vendor
  end

  def test_it_has_attributes
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_equal "Rocky Mountain Fresh", vendor.name
    assert_equal ({}), vendor.inventory
  end

  def test_it_can_check_stock
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_equal 0, vendor.check_stock("Peaches")
  end

  def test_it_can_stock_items
    vendor = Vendor.new("Rocky Mountain Fresh")

    vendor.stock("Peaches", 30)
    vendor.stock("Peaches", 30)
    vendor.stock("Pears", 25)

    assert_equal 60, vendor.check_stock("Peaches")
    assert_equal 25, vendor.check_stock("Pears")
  end

  def test_it_knows_inventory
    vendor = Vendor.new("Rocky Mountain Fresh")

    vendor.stock("Peaches", 30)
    vendor.stock("Peaches", 30)
    vendor.stock("Pears", 25)

    assert_equal ({"Peaches"=>60, "Pears"=>25}), vendor.inventory
  end
end
