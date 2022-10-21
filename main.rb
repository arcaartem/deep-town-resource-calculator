class Recipe
  attr_reader :item, :quantity, :duration, :ingredients

  def initialize(item:, quantity:, duration:, ingredients:)
    @item = item
    @quantity = quantity
    @duration = duration
    @ingredients = ingredients
  end
end

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

class Ingredient
  attr_reader :item, :quantity

  def initialize(item:, quantity:)
    @item = item
    @quantity = quantity
  end

  def *(other)
    Ingredient.new(item:, quantity: quantity * other)
  end
end

class RECIPE_BOOK
  INSULATED_WIRE = Recipe.new(
    item: ITEMS::INSULATED_WIRE,
    quantity: 1,
    duration: 200,
    ingredients: [
      Ingredient.new(item: ITEMS::AMBER_INSULATION, quantity: 1),
      Ingredient.new(item: ITEMS::WIRE, quantity: 1)
    ].freeze
  )
  AMBER_INSULATION = Recipe.new(
    item: ITEMS::AMBER_INSULATION,
    quantity: 1,
    duration: 20,
    ingredients: [
      Ingredient.new(item: ITEMS::ALUMINIUM_BOTTLE, quantity: 1),
      Ingredient.new(item: ITEMS::AMBER, quantity: 10)
    ].freeze
  )
  ALUMINIUM_BOTTLE = Recipe.new(
    item: ITEMS::ALUMINIUM_BOTTLE,
    quantity: 1,
    duration: 30,
    ingredients: [
      Ingredient.new(item: ITEMS::ALUMINIUM_BAR, quantity: 1),
    ].freeze
  )
  WIRE = Recipe.new(
    item: ITEMS::WIRE,
    quantity: 5,
    duration: 30,
    ingredients: [
      Ingredient.new(item: ITEMS::COPPER_BAR, quantity: 1),
    ].freeze
  )

  ALL = [
    INSULATED_WIRE,
    AMBER_INSULATION,
    ALUMINIUM_BOTTLE,
    WIRE
  ].freeze
end

class Crafter
  def craft(item:, quantity: 1)
    raise 'Item is not craftable' unless craftable?(item)

    recipe = find_recipe(item)
    raise "No recipe for item '#{item.name}'" if recipe.nil?

    {
      quantity_per_second: recipe.quantity / recipe.duration.to_f,
      total_duration: quantity / recipe.quantity.to_f * recipe.duration,
      total_required_ingredients: recipe.ingredients.map do |ingredient|
        if ingredient.item.type == :craftable
          craft(item: ingredient.item, quantity: (quantity / recipe.quantity.to_f) * ingredient.quantity)[:total_required_ingredients]
        else
          {
            name: ingredient.item.name,
            quantity: ingredient.quantity * (quantity / recipe.quantity.to_f)
          }
        end
      end.flatten
    }
  end

  private

  def craftable?(item)
    item.type == :craftable
  end

  def find_recipe(item)
    RECIPE_BOOK::ALL.find { |r| r.item.name == item.name }
  end
end

crafter = Crafter.new
pp crafter.craft(item: ITEMS::INSULATED_WIRE, quantity: 1)
