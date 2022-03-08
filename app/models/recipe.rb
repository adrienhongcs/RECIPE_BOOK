class Recipe < ApplicationRecord
    has_many :ingredients, dependent: :destroy
    has_many :directions, dependent: :destroy
end
