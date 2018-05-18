# frozen_string_literal: true

# A Game is what brings people to a Table, it's whatever they play
class Game < ApplicationRecord
  has_many :game_tables
  has_many :tables, through: :game_tables
  validates :name, presence: true, uniqueness: true
  validates :bgg_game_id, uniqueness: true

  before_validation :fetch_game_info

  def players_supported
    min = min_players_or_unknown
    max = max_players_or_unknown
    return min.to_s if min == max
    "#{min}-#{max}"
  end

  def min_players_or_unknown
    min_players || '?'
  end

  def max_players_or_unknown
    max_players || '?'
  end

  private

  def fetch_game_info
    return if Rails.env.test?

    return unless bgg_game_id.present? && bgg_game_id_changed?
    game_info = BggGameInfoFetcher.fetch_game_info(self)
    if game_info
      assign_attributes(game_info)
    else
      errors.add(:bgg_game_id, 'did not match a boardgame record on BGG')
    end
  end
end
