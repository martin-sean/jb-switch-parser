# Represents a game parsed from url
class Game < ApplicationRecord
  has_many :prices, dependent: :destroy
  has_and_belongs_to_many :refreshes
end