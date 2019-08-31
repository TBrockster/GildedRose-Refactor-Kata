# frozen_string_literal: true

require 'backstage_pass'

describe BackstagePass do
  before(:each) do
    @backstage_pass = BackstagePass.new('Backstage passes to a TAFKAL80ETC concert', 10, 10)
  end

  describe '#update_sell_in:' do
    it 'Reduces sell_in by 1.' do
      @backstage_pass.update_sell_in
      expect(@backstage_pass.sell_in).to eq 9
    end
  end

  describe '#update_quality' do
    # it 'Increases quality by 1.' do
    #   @aged_brie.update_quality
    #   expect(@aged_brie.quality).to eq 1
    # end
    # it 'Does not raise quality above 50.' do
    #   @high_quality_brie.update_quality
    #   expect(@high_quality_brie.quality).to eq 50
    # end
  end
end
