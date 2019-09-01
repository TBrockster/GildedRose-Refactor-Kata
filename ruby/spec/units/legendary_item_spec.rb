# frozen_string_literal: true

require 'legendary_item'

describe GenericItem do
  before(:each) do
    @sulfuras = LegendaryItem.new('Sulfuras, Hand of Ragnaros', 1, 80)
  end

  describe '#update_sell_in:' do
    it 'Does not reduce sell_in.' do
      @sulfuras.update_sell_in
      expect(@sulfuras.sell_in).to eq 1
    end
  end

  describe '#update_quality' do
    it 'Does not reduce quality.' do
      update_and_expect_quality(@sulfuras, 80)
    end
  end
end
