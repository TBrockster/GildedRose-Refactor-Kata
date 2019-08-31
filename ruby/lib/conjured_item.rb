# frozen_string_literal: true

class ConjuredItem < Item
  def update_sell_in
    @sell_in -= 1
  end

  def update_quality
    return if @quality <= 0

    @quality -= sell_in.negative? ? 4 : 2
  end
end
