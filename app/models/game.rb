# frozen_string_literal: true

# A Game is what brings people to a Table, it's whatever they play
class Game < ApplicationRecord
  has_and_belongs_to_many :tables
  validates :name, presence: true, uniqueness: true
  validates :bgg_game_id, uniqueness: true
end
