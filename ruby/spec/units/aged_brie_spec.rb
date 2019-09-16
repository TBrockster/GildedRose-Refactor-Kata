# frozen_string_literal: true

require 'aged_brie'

describe AgedBrie do
  before(:each) do
    @aged_brie = AgedBrie.new('Aged Brie', 10, 0)
    @high_quality_brie = AgedBrie.new('Aged Brie', 10, 50)
  end

  describe '#update_sell_in:' do
    it 'Reduces sell_in by 1.' do
      update_and_expect_sell_in(@aged_brie, 9)
    end
  end

  describe '#update_quality' do
    it 'Increases quality by 1.' do
      update_and_expect_quality(@aged_brie, 1)
    end
    it 'Does not raise quality above 50.' do
      update_and_expect_quality(@high_quality_brie, 50)
    end
  end
end
