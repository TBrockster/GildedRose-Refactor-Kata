# frozen_string_literal: true

require 'item'

# this class models the BackstagePass item type.
class BackstagePass < Item
  def update_sell_in
    @sell_in -= 1
  end

  def update_quality
    case @sell_in
    when 10..(1.0 / 0)
      @quality += 1
    when 5..9
      @quality += 2
    when 0..5
      @quality += 3
    when (-1.0 / 0)..0
      @quality = 0
    end
  end
end
