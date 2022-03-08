# frozen_string_literal: true

module Types
  class RecipeType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :ingredients, [Types::IngredientType], null: false
    field :directions, [Types::DirectionType], null: false
  end
end
