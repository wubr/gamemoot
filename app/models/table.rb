# frozen_string_literal: true

# A Table is where a game is played, either literally or figuratively
class Table < ApplicationRecord
  has_many :game_tables
  has_many :games, through: :game_tables
  validates :name, presence: true
end
