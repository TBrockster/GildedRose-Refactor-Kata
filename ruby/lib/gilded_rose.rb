# frozen_string_literal: true

require 'item'
require 'generic_item'
require 'aged_brie'
require 'legendary_item'
require 'backstage_pass'
require 'conjured_item'

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
