# frozen_string_literal: true

require 'aged_brie'
require 'backstage_pass'
require 'conjured_item'
require 'generic_item'
require 'gilded_rose'
require 'item'
require 'legendary_item'

describe GildedRose do
  describe '#update_inventory:' do
    describe 'Generic Items:' do
      before(:each) do
        @fresh_item = [GenericItem.new('foo', 200, 50)]
        @stale_item = [GenericItem.new('foo', 0, 50)]
        @low_quality_item = [GenericItem.new('foo', 0, 0)]
      end
      it 'Reduces sell_in value by 1.' do
        update_inventory_and_expect_sell_in(@fresh_item, 199)
      end
      it 'Reduces quality value by 1, while sell_in is 1 or more.' do
        update_inventory_and_expect_quality(@fresh_item, 49)
      end
      it 'Reduces quality value by 2, while sell_in is 0 or less.' do
        update_inventory_and_expect_quality(@stale_item, 48)
      end
      it 'Does not reduce the quality of an item to a negtive amount.' do
        update_inventory_and_expect_quality(@low_quality_item, 0)
      end
    end

    describe 'Aged Brie:' do
      before(:each) do
        @aged_brie = [AgedBrie.new('Aged Brie', 10, 0)]
        @high_quality_brie = [AgedBrie.new('Aged Brie', 10, 50)]
      end
      it 'Decreases sell_in value by 1.' do
        update_inventory_and_expect_sell_in(@aged_brie, 9)
      end
      it 'Increases the quality of Aged Brie.' do
        update_inventory_and_expect_quality(@aged_brie, 1)
      end
      it 'Does not increase quality above 50.' do
        update_inventory_and_expect_quality(@high_quality_brie, 50)
      end
    end

    describe 'Sulfuras, Hand of Ragnaros:' do
      before(:each) do
        @sulfuras = [LegendaryItem.new('Sulfuras, Hand of Ragnaros', 1, 80)]
      end
      it 'Does not change the sell_in of Sulfuras.' do
        update_inventory_and_expect_sell_in(@sulfuras, 1)
      end
      it 'Does not change the quality of Sulfuras.' do
        update_inventory_and_expect_quality(@sulfuras, 80)
      end
    end

    describe 'Backstage Pass criteria:' do
      before(:each) do
        @expired_pass = [BackstagePass.new('Backstage passes to a TAFKAL80ETC concert', 0, 10)]
        @one_day_pass = [BackstagePass.new('Backstage passes to a TAFKAL80ETC concert', 1, 10)]
        @five_day_pass = [BackstagePass.new('Backstage passes to a TAFKAL80ETC concert', 5, 10)]
        @six_day_pass = [BackstagePass.new('Backstage passes to a TAFKAL80ETC concert', 6, 10)]
        @ten_day_pass = [BackstagePass.new('Backstage passes to a TAFKAL80ETC concert', 10, 10)]
        @eleven_day_pass = [BackstagePass.new('Backstage passes to a TAFKAL80ETC concert', 11, 10)]
      end
      it 'Decreases sell_in value by 1.' do
        update_inventory_and_expect_sell_in(@expired_pass, -1)
      end
      it 'Reduces pass quality to 0 when sell_in is less than 0.' do
        update_inventory_and_expect_quality(@expired_pass, 0)
      end
      it 'Increases pass quality by 3 while sell_in is between 0 and 5.' do
        update_inventory_and_expect_quality(@one_day_pass, 13)
        update_inventory_and_expect_quality(@five_day_pass, 13)
      end
      it 'Increases pass quality by 2 while sell_in is between 6 and 10.' do
        update_inventory_and_expect_quality(@six_day_pass, 12)
        update_inventory_and_expect_quality(@ten_day_pass, 12)
      end
      it 'Increases pass quality by 1 while sell_in is above 10.' do
        update_inventory_and_expect_quality(@eleven_day_pass, 11)
      end
    end

    describe 'Conjured Items:' do
      before(:each) do
        @conjured_item = [ConjuredItem.new('Conjured Mana Cake', 5, 10)]
        @stale_conjured_item = [ConjuredItem.new('Conjured Mana Cake', 0, 10)]
        @low_quality_conjured_item = [ConjuredItem.new('Conjured Mana Cake', 5, 0)]
      end
      it 'Decreases sell_in value by 1.' do
        update_inventory_and_expect_sell_in(@conjured_item, 4)
      end
      it 'Reduces the quality of conjured items by 2 while sell_in is 0 or less.' do
        update_inventory_and_expect_quality(@conjured_item, 8)
      end
      it 'Reduces the quality of conjured items by 4 while sell_in is less than 0.' do
        update_inventory_and_expect_quality(@stale_conjured_item, 6)
      end
      it 'Does not reduce the quality of an item to a negtive amount.' do
        update_inventory_and_expect_quality(@low_quality_conjured_item, 0)
      end
    end
  end
end
