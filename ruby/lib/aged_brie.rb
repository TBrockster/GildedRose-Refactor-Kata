# frozen_string_literal: true

require 'item'
require 'default_behaviour_module'

# this class models the AgedBrie item type.
class AgedBrie < Item
  include DefaultBehaviour
  def update_quality
    return if @quality >= 50

    @quality += 1
  end
end
