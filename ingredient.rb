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