require './recipe'
require './item'
require './ingredient'
require './solver'

crafter = Crafter.new
pp crafter.craft(item: ITEMS::INSULATED_WIRE, quantity: 1)
