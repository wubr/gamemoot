# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BggGameInfoFetcher do
  describe '::fetch_game_info' do
    let(:game) { instance_double('Game', bgg_game_id: 1357) }

    it 'calls BggApi::game_info' do
      expect(BggApi).to receive(:game_info).with(1357)
      BggGameInfoFetcher.fetch_game_info(game)
    end
  end
end
