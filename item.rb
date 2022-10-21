class Item
  attr_reader :name, :type

  def initialize(name:, type:)
    @name = name
    @type = type
  end
end

class CraftableItem < Item
  def initialize(name:)
    super(name:, type: :craftable)
  end
end

class MineableItem < Item
  def initialize(name:)
    super(name:, type: :mineable)
  end
end

class SmeltableItem < Item
  def initialize(name:)
    super(name:, type: :smeltable)
  end
end

class ITEMS
  INSULATED_WIRE = CraftableItem.new(name: 'Insulated wire')
  AMBER_INSULATION = CraftableItem.new(name: 'Amber insulation')
  ALUMINIUM_BOTTLE = CraftableItem.new(name: 'Aluminium bottle')
  ALUMINIUM_BAR = SmeltableItem.new(name: 'Aluminium bar')
  COPPER_BAR = SmeltableItem.new(name: 'Copper bar')
  AMBER = MineableItem.new(name: 'Amber')
  WIRE = CraftableItem.new(name: 'Wire')
end
