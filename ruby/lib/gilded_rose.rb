# frozen_string_literal: true

# handles updating the store inventory at the end of each day.
class GildedRose
  SELL_IN_EXCEPTIONS = ['Sulfuras, Hand of Ragnaros'].freeze
  QUALITY_EXCEPTIONS = ['Sulfuras, Hand of Ragnaros'].freeze
  def initialize(items)
    @items = items
  end

  def update_inventory
    @items.each do |item|
      update_sell_in(item)
      update_quality(item)
    end
  end

  def update_sell_in(item)
    return if SELL_IN_EXCEPTIONS.include? item.name

    item.sell_in -= 1
  end

  def update_quality(item)
    case item.name
    when 'Sulfuras, Hand of Ragnaros'
      # nothing effects Sulfuras, Hand of Ragnaros! (except RuboCop warnings)
    when 'Backstage passes to a TAFKAL80ETC concert'
      update_backstage_pass_quality(item)
    when 'Aged Brie'
      item.quality += 1
    else
      item.quality -= item.sell_in.negative? ? 2 : 1
    end
    item_quality_check(item)
  end

  def update_backstage_pass_quality(item)
    case item.sell_in
    when 10..(1.0 / 0)
      item.quality += 1
    when 5...10
      item.quality += 2
    when 0..5
      item.quality += 3
    when (-1.0 / 0)..0
      item.quality = 0
    end
  end

  def item_quality_check(item)
    return if QUALITY_EXCEPTIONS.include? item.name

    item.quality = 0 if item.quality.negative?
    item.quality = 50 if item.quality > 50
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
