# frozen_string_literal: true

require 'generic_item'

describe GenericItem do
  before(:each) do
    @fresh_item = GenericItem.new('foo', 200, 50)
    @stale_item = GenericItem.new('foo', 0, 50)
    @low_quality_item = GenericItem.new('foo', 0, 0)
  end

  describe '#update_sell_in:' do
    it 'Reduces sell_in by 1.' do
      @fresh_item.update_sell_in
      expect(@fresh_item.sell_in).to eq 199
    end
  end

  describe '#update_quality' do
    it 'Reduces quality by 1, while sell_in is 1 or more.' do
      update_and_expect_quality(@fresh_item, 49)
    end
  end
end
