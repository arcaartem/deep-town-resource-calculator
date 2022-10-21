require './recipe'

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