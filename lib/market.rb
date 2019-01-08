require 'pry'
class Market

  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    vendors_that_sell = []
    @vendors.each do |vendor|
      if vendor.inventory.keys.include?(item)
        vendors_that_sell << vendor
      end
    end
    return vendors_that_sell
  end

  def sorted_item_list
    sorted_item_list = []
    @vendors.each do |vendor|
      vendor.inventory.keys.each do |item|
        if !sorted_item_list.include?(item)
          sorted_item_list << item
        end
      end
    end
    sorted_item_list.sort! {|item, item_2| item <=> item_2}
  end

  def total_inventory
    total_inventory = Hash.new(0)
      @vendors.each do |vendor|
        vendor.inventory.each do |stock, amount|
          total_inventory[stock] += amount
        end
      end
    return total_inventory
  end

  def sell(item, amount)
    true_or_false = self.can_sell?(item, amount)
    running_total = amount
    if self.can_sell?(item, amount)
      until running_total == 0
        @vendors.each do |vendor|
          until vendor.inventory[item] == 0 || running_total == 0
            vendor.inventory[item] -= 1
            running_total -= 1
          end
        end
      end
    end
    return true_or_false
  end

  def can_sell?(item, amount)
    if self.sorted_item_list.include?(item) && self.total_inventory[item] > amount
      return true
    else
      return false
    end
  end
end
