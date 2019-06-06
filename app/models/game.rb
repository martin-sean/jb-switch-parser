# Represents a game parsed from url
class Game < ApplicationRecord
  has_many :prices, dependent: :destroy
end