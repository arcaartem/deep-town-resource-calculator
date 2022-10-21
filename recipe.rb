require './item'
require './ingredient'

class Recipe
  attr_reader :item, :quantity, :duration, :ingredients

  def initialize(item:, quantity:, duration:, ingredients:)
    @item = item
    @quantity = quantity
    @duration = duration
    @ingredients = ingredients
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