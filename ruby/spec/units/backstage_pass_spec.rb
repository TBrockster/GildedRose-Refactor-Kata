# frozen_string_literal: true

require 'backstage_pass'

describe BackstagePass do
  before(:each) do
    @expired_pass = BackstagePass.new('Backstage passes to a TAFKAL80ETC concert', 0, 10)
    @one_day_pass = BackstagePass.new('Backstage passes to a TAFKAL80ETC concert', 1, 10)
    @five_day_pass = BackstagePass.new('Backstage passes to a TAFKAL80ETC concert', 5, 10)
    @six_day_pass = BackstagePass.new('Backstage passes to a TAFKAL80ETC concert', 6, 10)
    @ten_day_pass = BackstagePass.new('Backstage passes to a TAFKAL80ETC concert', 10, 10)
    @eleven_day_pass = BackstagePass.new('Backstage passes to a TAFKAL80ETC concert', 11, 10)
  end

  describe '#update_sell_in:' do
    it 'Reduces sell_in by 1.' do
      @expired_pass.update_sell_in
      expect(@expired_pass.sell_in).to eq(-1)
    end
  end

  describe '#update_quality' do
    it 'Reduces pass quality to 0 when sell_in is less than 0.' do
      @expired_pass.update_sell_in
      @expired_pass.update_quality
      expect(@expired_pass.quality).to eq 0
    end
  end
end
