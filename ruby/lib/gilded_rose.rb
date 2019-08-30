# frozen_string_literal: true

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item.sell_in -= 1
      case item.name
      when 'Sulfuras, Hand of Ragnaros'
        item.sell_in += 1
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
