# frozen_string_literal: true

require 'item'

describe Item do
  before(:each) do
    @super_restore = Item.new('Super Restore', 5, 10)
  end

  describe '#to_s:' do
    it 'Correctly prints out the name, sell_in and quality.' do
      expect(@super_restore.to_s).to eq 'Super Restore, 5, 10'
    end
  end
end
