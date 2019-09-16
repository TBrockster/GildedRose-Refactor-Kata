# frozen_string_literal: true

module DefaultBehaviour
  def update_sell_in
    @sell_in -= 1
  end

  def update_quality
    return if @quality <= 0

    @quality -= sell_in.negative? ? 2 : 1
  end
end
