# frozen_string_literal: true

require 'item'
require 'default_behaviour_module'

# this class models the Generic item type.
class GenericItem < Item
  include DefaultBehaviour
end
