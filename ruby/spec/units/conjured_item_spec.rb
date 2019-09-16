# frozen_string_literal: true

require 'conjured_item'

describe ConjuredItem do
  before(:each) do
    @conjured_item = ConjuredItem.new('Conjured Mana Cake', 5, 10)
    @stale_conjured_item = ConjuredItem.new('Conjured Mana Cake', 0, 10)
    @low_quality_conjured_item = ConjuredItem.new('Conjured Mana Cake', 5, 0)
  end

  describe '#update_sell_in:' do
    it 'Reduces sell_in by 1.' do
      update_and_expect_sell_in(@conjured_item, 4)
    end
  end

  describe '#update_quality' do
    it 'Reduces the quality by 2 while sell_in is 0 or less.' do
      update_and_expect_quality(@conjured_item, 8)
    end
    it 'Reduces the quality by 4 while sell_in is less than 0.' do
      update_and_expect_quality(@stale_conjured_item, 6)
    end
    it 'Does not reduce the quality of an item to a negative amount.' do
      update_and_expect_quality(@low_quality_conjured_item, 0)
    end
  end
end
