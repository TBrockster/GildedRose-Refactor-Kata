# frozen_string_literal: true

class GildedRose
  SELL_IN_EXCEPTIONS = ['Sulfuras, Hand of Ragnaros'].freeze
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
    item.sell_in -= 1 unless SELL_IN_EXCEPTIONS.include? item.name
  end

  def update_quality(item)
    case item.name
    when 'Sulfuras, Hand of Ragnaros'
      # nothing effects Sulfuras, Hand of Ragnaros!
    when 'Backstage passes to a TAFKAL80ETC concert'
      case item.sell_in
      when 10..(1.0 / 0)
        item.quality += 1 if item.quality < 50
      when 5...10
        item.quality += 2 if item.quality < 50
      when 0..5
        item.quality += 3 if item.quality < 50
      when (-1.0 / 0)..0
        item.quality = 0
      end
    when 'Aged Brie'
      item.quality += 1 if item.quality < 50
    else
      item.quality -= 1 if item.quality > 0
      item.quality -= 1 if item.quality > 0 && item.sell_in < 0
    end
  end
end

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
