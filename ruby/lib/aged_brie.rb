# frozen_string_literal: true

class AgedBrie < Item
  def update_sell_in
    @sell_in -= 1
  end

  def update_quality
    return if @quality >= 50

    @quality += 1
  end
end
