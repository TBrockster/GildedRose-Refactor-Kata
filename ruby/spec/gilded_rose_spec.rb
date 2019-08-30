# frozen_string_literal: true

require 'gilded_rose'

describe GildedRose do
  describe '#update_inventory:' do
    describe 'Generic Items:' do
      before(:each) do
        @fresh_item = [Item.new('foo', 200, 50)]
        @stale_item = [Item.new('foo', 0, 50)]
        @low_quality_item = [Item.new('foo', 0, 0)]
      end
      it 'Decreases sell_in value by 1.' do
        GildedRose.new(@fresh_item).update_inventory
        expect(@fresh_item[0].sell_in).to eq 199
      end
      it 'Decreases quality value by 1, while sell_in is 1 or more.' do
        GildedRose.new(@fresh_item).update_inventory
        expect(@fresh_item[0].quality).to eq 49
      end
      it 'Decreases quality value by 2, while sell_in is 0 or less.' do
        GildedRose.new(@stale_item).update_inventory
        expect(@stale_item[0].quality).to eq 48
      end
      it 'Does not reduce the quality of an item to a negtive amount.' do
        GildedRose.new(@low_quality_item).update_inventory
        expect(@low_quality_item[0].quality).to eq 0
      end
    end

    describe 'Aged Brie:' do
      before(:each) do
        @aged_brie = [Item.new('Aged Brie', 10, 0)]
        @high_quality_brie = [Item.new('Aged Brie', 10, 50)]
      end
      it 'Decreases sell_in value by 1.' do
        GildedRose.new(@aged_brie).update_inventory
        expect(@aged_brie[0].sell_in).to eq 9
      end
      it 'Increases the quality of Aged Brie.' do
        GildedRose.new(@aged_brie).update_inventory
        expect(@aged_brie[0].quality).to eq 1
      end
      it 'Does not increase quality above 50.' do
        GildedRose.new(@high_quality_brie).update_inventory
        expect(@high_quality_brie[0].quality).to eq 50
      end
    end

    describe 'Sulfuras, Hand of Ragnaros:' do
      before(:each) do
        @sulfuras = [Item.new('Sulfuras, Hand of Ragnaros', 1, 80)]
      end
      it 'Does not change the sell_in of Sulfuras.' do
        GildedRose.new(@sulfuras).update_inventory
        expect(@sulfuras[0].sell_in).to eq 1
      end
      it 'Does not change the quality of Sulfuras.' do
        GildedRose.new(@sulfuras).update_inventory
        expect(@sulfuras[0].quality).to eq 80
      end
    end

    describe 'Backstage Pass criteria:' do
      before(:each) do
        @expired_pass = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 10)]
        @one_day_pass = [Item.new('Backstage passes to a TAFKAL80ETC concert', 1, 10)]
        @five_day_pass = [Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 10)]
        @six_day_pass = [Item.new('Backstage passes to a TAFKAL80ETC concert', 6, 10)]
        @ten_day_pass = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 10)]
        @eleven_day_pass = [Item.new('Backstage passes to a TAFKAL80ETC concert', 11, 10)]
      end
      it 'Decreases sell_in value by 1.' do
        GildedRose.new(@expired_pass).update_inventory
        expect(@expired_pass[0].sell_in).to eq(-1)
      end
      it 'Reduces pass quality to 0 when sell_in is less than 0.' do
        GildedRose.new(@expired_pass).update_inventory
        expect(@expired_pass[0].quality).to eq 0
      end
      it 'Increases pass quality by 3 while sell_in is between 0 and 5.' do
        GildedRose.new(@one_day_pass).update_inventory
        expect(@one_day_pass[0].quality).to eq 13
        GildedRose.new(@five_day_pass).update_inventory
        expect(@five_day_pass[0].quality).to eq 13
      end
      it 'Increases pass quality by 2 while sell_in is between 6 and 10.' do
        GildedRose.new(@six_day_pass).update_inventory
        expect(@six_day_pass[0].quality).to eq 12
        GildedRose.new(@ten_day_pass).update_inventory
        expect(@ten_day_pass[0].quality).to eq 12
      end
      it 'Increases pass quality by 1 while sell_in is above 10.' do
        GildedRose.new(@eleven_day_pass).update_inventory
        expect(@eleven_day_pass[0].quality).to eq 11
      end
    end

    describe 'Conjured Items:' do
      before(:each) do
        @conjured_item = [Item.new('Conjured Mana Cake', 5, 10)]
        @stale_conjured_item = [Item.new('Conjured Mana Cake', 0, 10)]
        @low_quality_conjured_item = [Item.new('Conjured Mana Cake', 5, 0)]
      end
      it 'Decreases sell_in value by 1.' do
        GildedRose.new(@conjured_item).update_inventory
        expect(@conjured_item[0].sell_in).to eq(4)
      end
      it 'Reduces the quality of conjured items by 2 while sell_in is 0 or higher.' do
        GildedRose.new(@conjured_item).update_inventory
        expect(@conjured_item[0].quality).to eq 8
      end
      it 'Reduces the quality of conjured items by 2 while sell_in is below 0' do
        GildedRose.new(@stale_conjured_item).update_inventory
        expect(@stale_conjured_item[0].quality).to eq 6
      end
      it 'Does not reduce the quality of an item to a negtive amount.' do
        GildedRose.new(@low_quality_conjured_item).update_inventory
        expect(@low_quality_conjured_item[0].quality).to eq 0
      end
    end
  end
end
