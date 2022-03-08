module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :recipes,
      [Types::RecipeType], 
      null: false,
      description: "Returns a list of recipes in the recipe book" 

    field :recipe, Types::RecipeType, null: false do
      argument :id, ID, required: true
    end
    
    field :ingredients,
      [Types::IngredientType], 
      null: false,
      description: "Returns a list of ingredients in the recipe book" 
    
    field :directions,
      [Types::DirectionType], 
      null: false,
      description: "Returns a list of directions in the recipe book"
    
    def recipes 
      Recipe.all
    end

    def recipe(id:)
      Recipe.find(id)
    end

    def ingredients
      Ingredient.all
    end

    def directions
      Direction.all
    end
  end
end
