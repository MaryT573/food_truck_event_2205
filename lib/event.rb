require './lib/item'
require './lib/food_truck'

class Event
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(truck)
    @food_trucks << truck
  end

  def food_trucks_that_sell(item)
    trucks = []
    @food_trucks.each do |truck|
      truck.inventory.each do |x|
        x.each do |y|
          if item == y
            trucks << truck
          else
            next
          end
        end
      end
    end
    trucks.uniq
  end

  def food_trucks_names
    names = @food_trucks.map {|truck| truck.name}
  end

  def sorted_item_list
    items = @food_trucks.map {|truck| truck.inventory.keys}
    names = []
    items.each do |item|
      item.each do |x|
        names << x.name
      end
    end
    names.uniq.sort
  end

  def total_inventory
    total_inv = {}
    @food_trucks.each do |truck|
      truck.inventory.each do |item, amount|
        if total_inv.keys.include?(item)
          total_inv[item][:quantity] += amount
        else
          total_inv[item] = {quantity: amount, food_trucks: food_trucks_that_sell(item)}
        end
      end
    end
    return total_inv
  end
end
