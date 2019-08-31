require 'aged_brie'

describe AgedBrie do
  before(:each) do
    @aged_brie = AgedBrie.new('Aged Brie', 10, 0)
  end
  describe '#update_sell_in:' do
    it 'Reduces sell_in by 1.' do
      @aged_brie.update_sell_in
      expect(@aged_brie.sell_in).to eq 9
    end
  end
  describe '#update_quality' do
  end
end