# frozen_string_literal: true

require 'aged_brie'

describe AgedBrie do
  before(:each) do
    @aged_brie = AgedBrie.new('Aged Brie', 10, 0)
    @high_quality_brie = AgedBrie.new('Aged Brie', 10, 50)
  end

  describe '#update_sell_in:' do
    it 'Reduces sell_in by 1.' do
      @aged_brie.update_sell_in
      expect(@aged_brie.sell_in).to eq 9
    end
  end

  describe '#update_quality' do
    it 'Increases quality by 1.' do
      @aged_brie.update_quality
      expect(@aged_brie.quality).to eq 1
    end
    it 'Does not raise quality above 50.' do
      @high_quality_brie.update_quality
      expect(@high_quality_brie.quality).to eq 50
    end
  end
end
