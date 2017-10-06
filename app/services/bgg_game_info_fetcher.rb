# frozen_string_literal: true
class BggGameInfoFetcher
  def fetch_game_info(game)
    BggApi.new.game_info(game.bgg_game_id)
  end
end