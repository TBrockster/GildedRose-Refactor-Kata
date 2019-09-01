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
      @conjured_item.update_sell_in
      expect(@conjured_item.sell_in).to eq 4
    end
  end

  describe '#update_quality' do

  end
end
