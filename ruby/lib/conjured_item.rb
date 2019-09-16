# frozen_string_literal: true

require 'item'
require 'default_behaviour_module'

# this class models the Conjured item type.
class ConjuredItem < Item
  include DefaultBehaviour
  
  def update_quality
    return if @quality <= 0

    @quality -= sell_in.negative? ? 4 : 2
  end
end
