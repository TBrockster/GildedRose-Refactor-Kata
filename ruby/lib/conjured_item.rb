# frozen_string_literal: true

require 'item'

# this class models the Conjured item type.
class ConjuredItem < Item
  def update_sell_in
    @sell_in -= 1
  end

  def update_quality
    return if @quality <= 0

    @quality -= sell_in.negative? ? 4 : 2
  end
end
