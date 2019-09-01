# frozen_string_literal: true

require 'gilded_rose'

describe GildedRose do
  let(:gilded_rose) { double :fake_gilded_rose }

  describe '#update_inventory:' do
    it 'Sends the update_sell_in message.' do
      allow(gilded_rose).to receive(:update_quality)
      expect(gilded_rose).to receive(:update_sell_in)
      GildedRose.new([gilded_rose]).update_inventory
    end
    it 'Sends the update_quality message.' do
      allow(gilded_rose).to receive(:update_sell_in)
      expect(gilded_rose).to receive(:update_quality)
      GildedRose.new([gilded_rose]).update_inventory
    end
  end
end
