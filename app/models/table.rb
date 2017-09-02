# frozen_string_literal: true

# A Table is where a game is played, either literally or figuratively
class Table < ApplicationRecord
  has_and_belongs_to_many :games
  validates :name, presence: true
end
