# frozen_string_literal: true

require 'gilded_rose'

describe GildedRose do
  before(:each) do
    @fresh_items = [Item.new('foo', 200, 50)]
    @stale_items = [Item.new('foo', 0, 50)]
    @low_quality_items = [Item.new('foo', 0, 0)]
    @aged_brie = [Item.new('Aged Brie', 10, 0)]
    @high_quality_brie = [Item.new('Aged Brie', 10, 50)]
    @sulfuras = [Item.new('Sulfuras, Hand of Ragnaros', 1, 80)]
    @conjured_item = [Item.new('Conjured Mana Cake', 5, 10)]
  end
  describe '#update_quality:' do
    describe 'Simple criteria:' do
      it 'Does not change the name.' do
        GildedRose.new(@fresh_items).update_quality
        expect(@fresh_items[0].name).to eq 'foo'
      end
      it 'Decreases Quality value by 1, while SellIn is greater than 0.' do
        GildedRose.new(@fresh_items).update_quality
        expect(@fresh_items[0].quality).to eq 49
      end
      it 'Decreases SellIn value by 1.' do
        GildedRose.new(@fresh_items).update_quality
        expect(@fresh_items[0].sell_in).to eq 199
      end
    end

    describe 'Complex criteria:' do
      it 'Decreases Quality value by 2, while SellIn is less than 1.' do
        GildedRose.new(@stale_items).update_quality
        expect(@stale_items[0].quality).to eq 48
      end
      it 'Does not reduce the quality of an item to a negtive amount' do
        GildedRose.new(@low_quality_items).update_quality
        expect(@low_quality_items[0].quality).to eq 0
      end
      it 'Increases the quality of Aged Brie' do
        GildedRose.new(@aged_brie).update_quality
        expect(@aged_brie[0].quality).to eq 1
      end
      it 'Does not increase quality above 50' do
        GildedRose.new(@high_quality_brie).update_quality
        expect(@high_quality_brie[0].quality).to eq 50
      end
      it 'Does not change the SellIn or quality of Sulfuras' do
        GildedRose.new(@sulfuras).update_quality
        expect(@sulfuras[0].sell_in).to eq 1
        expect(@sulfuras[0].quality).to eq 80
      end
      xit 'Reduces the quality of conjured items twice as much' do
        GildedRose.new(@conjured_item).update_quality
        expect(@conjured_item[0].quality).to eq
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
        it 'Reduces pass quality to 0 when sell in < 0' do
          GildedRose.new(@expired_pass).update_quality
          expect(@expired_pass[0].quality).to eq 0
        end
        it 'Increases pass quality by 3 while 5 > sell in > 0' do
          GildedRose.new(@one_day_pass).update_quality
          expect(@one_day_pass[0].quality).to eq 13
          GildedRose.new(@five_day_pass).update_quality
          expect(@five_day_pass[0].quality).to eq 13
        end
        it 'Increases pass quality by 2 while 10 > sell in > 6' do
          GildedRose.new(@six_day_pass).update_quality
          expect(@six_day_pass[0].quality).to eq 12
          GildedRose.new(@ten_day_pass).update_quality
          expect(@ten_day_pass[0].quality).to eq 12
        end
        it 'Increases pass quality by 1 while sell_in > 10' do
          GildedRose.new(@eleven_day_pass).update_quality
          expect(@eleven_day_pass[0].quality).to eq 11
        end
      end
    end
  end
end
