# frozen_string_literal: true

# A Game is what brings people to a Table, it's whatever they play
class Game < ApplicationRecord
  has_many :game_tables
  has_many :tables, through: :game_tables
  validates :name, presence: true, uniqueness: true
  validates :bgg_game_id, uniqueness: true

  before_save :fetch_game_info

  private
  def fetch_game_info
    if(bgg_game_id.present? && bgg_game_id_changed?)
      assign_attributes(BggGameInfoFetcher.new.fetch_game_info(self))
    end
  end
end
