# frozen_string_literal: true

# Join table for Games and Tables
class GameTable < ApplicationRecord
  belongs_to :game
  belongs_to :table

  validates :game_id, presence: true
  validates :table_id, presence: true
end
