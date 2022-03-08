# frozen_string_literal: true

module Types
  class DirectionType < Types::BaseObject
    field :id, ID, null: false
    field :description, String
    field :recipe_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
