# frozen_string_literal: true

# Responsible for getting information about a Boardgame
class BggGameInfoFetcher
  def self.fetch_game_info(game)
    BggApi.game_info(game.bgg_game_id)
  end
end
