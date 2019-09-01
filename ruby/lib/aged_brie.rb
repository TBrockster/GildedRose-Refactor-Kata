# frozen_string_literal: true

require 'item'

# this class models the AgedBrie item type.
class AgedBrie < Item
  def update_sell_in
    @sell_in -= 1
  end

  def update_quality
    return if @quality >= 50

    @quality += 1
  end
end
