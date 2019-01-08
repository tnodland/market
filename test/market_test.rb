require './lib/vendor'
require './lib/market'
require 'minitest/autorun'
require 'minitest/pride'

class MarketTest < Minitest::Test
  def test_it_exists
    market = Market.new("name")

    assert_instance_of Market, market
  end

  def test_it_has_attributes
    market = Market.new("South Pearl Street Farmers Market")

    assert_equal "South Pearl Street Farmers Market", market.name
    assert_equal [], market.vendors
  end

  def test_it_can_add_vednors
    market = Market.new("South Pearl Street Farmers Market")
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    vendor_3 = Vendor.new("Palisade Peach Shack")

    market.add_vendor(vendor_1)
    market.add_vendor(vendor_2)
    market.add_vendor(vendor_3)

    assert_equal [vendor_1, vendor_2, vendor_3], market.vendors
  end

  def test_it_knows_vendor_names
    market = Market.new("South Pearl Street Farmers Market")
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    vendor_3 = Vendor.new("Palisade Peach Shack")
    market.add_vendor(vendor_1)
    market.add_vendor(vendor_2)
    market.add_vendor(vendor_3)

    assert_equal ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"], market.vendor_names
  end

  def test_it_knows_vendors_that_sell_items
    market = Market.new("South Pearl Street Farmers Market")
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)
    vendor_1.stock("Tomatoes", 7)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    vendor_2.stock("Banana Nice Cream", 50)
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    vendor_3 = Vendor.new("Palisade Peach Shack")
    vendor_3.stock("Peaches", 65)
    market.add_vendor(vendor_1)
    market.add_vendor(vendor_2)
    market.add_vendor(vendor_3)

    assert_equal [vendor_1, vendor_3], market.vendors_that_sell("Peaches")
    assert_equal [vendor_2], market.vendors_that_sell("Banana Nice Cream")
  end
end