# frozen_string_literal: true

# this class models the Generic item type.
class GenericItem < Item
  def update_sell_in
    @sell_in -= 1
  end

  def update_quality
    return if @quality <= 0

    @quality -= sell_in.negative? ? 2 : 1
  end
end
