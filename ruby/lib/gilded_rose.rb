# frozen_string_literal: true

# handles updating the store inventory at the end of each day.
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_inventory
    @items.each do |item|
      item.update_sell_in
      item.update_quality
    end
  end
end

# handles the item class that the shop stores - unchanged from original code.
class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

class GenericItem < Item
  def update_sell_in
    @sell_in -= 1
  end

  def update_quality
    return if @quality <= 0

    @quality -= sell_in.negative? ? 2 : 1
  end
end

class AgedBrie < Item
  def update_sell_in
    @sell_in -= 1
  end

  def update_quality
    return if @quality >= 50

    @quality += 1
  end
end

class LegendaryItem < Item
  def update_sell_in; end

  def update_quality; end
end

class BackstagePass < Item
  def update_sell_in
    @sell_in -= 1
  end

  def update_quality
    case @sell_in
    when 10..(1.0 / 0)
      @quality += 1
    when 5..9
      @quality += 2
    when 0..5
      @quality += 3
    when (-1.0 / 0)..0
      @quality = 0
    end
  end
end

class ConjuredItem < Item
  def update_sell_in
    @sell_in -= 1
  end

  def update_quality
    return if @quality <= 0

    @quality -= sell_in.negative? ? 4 : 2
  end
end
