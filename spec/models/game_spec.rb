# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) { Game.new }
  subject { game }

  it { is_expected.to have_many :game_tables }
  it { is_expected.to have_many :tables }

  describe 'validation' do
    before do
      subject.valid?
    end

    describe 'name' do
      it 'cannot be blank' do
        expect(subject.errors[:name]).to include "can't be blank"
      end

      context 'when other games exist' do
        let(:other_game) { Game.create!(name: 'Game A', bgg_game_id: '12345') }
        let(:game) { Game.new(name: other_game.name, bgg_game_id: '54321') }

        it 'must be unique' do
          expect(subject.errors[:name]).to include 'has already been taken'
        end
      end
    end

    describe 'bgg_game_id' do
      context 'when other games exist' do
        let(:other_game) { Game.create!(name: 'Game A', bgg_game_id: '12345') }
        let(:game) { Game.new(name: 'Game 1', bgg_game_id: other_game.bgg_game_id) }

        it 'must be unique' do
          expect(subject.errors[:bgg_game_id]).to include 'has already been taken'
        end
      end
    end
  end

  describe '#players_supported' do
    context 'when min and max players is set to 2 and 5' do
      let(:game) { Game.new min_players: 2, max_players: 5 }

      it 'returns the range of players supported' do
        expect(game.players_supported).to eq '2-5'
      end
    end

    context 'when min and max players are nil' do
      it 'returns ?' do
        expect(game.players_supported).to eq '?'
      end
    end

    context 'when min players is 2 and max players is not set' do
      let(:game) { Game.new min_players: 2 }
      it 'returns 2-?' do
        expect(game.players_supported).to eq '2-?'
      end
    end

    context 'when max players is 5 and min players is not set' do
      let(:game) { Game.new max_players: 5 }
      it 'returns ?-5' do
        expect(game.players_supported).to eq '?-5'
      end
    end

    context 'when min and max players are set to 3' do
      let(:game) { Game.new min_players: 3, max_players: 3 }
      it 'returns 3' do
        expect(game.players_supported).to eq '3'
      end
    end
  end

  describe '#playtime' do
    context 'when min and max playtime is set to 2 and 5' do
      let(:game) { Game.new min_playtime_minutes: 2, max_playtime_minutes: 5 }

      it 'returns the range of playtime' do
        expect(game.playtime_minutes).to eq '2-5'
      end
    end

    context 'when min and max playtime are nil' do
      it 'returns ?' do
        expect(game.playtime_minutes).to eq '?'
      end
    end

    context 'when min playtime is 2 and max playtime is not set' do
      let(:game) { Game.new min_playtime_minutes: 2 }
      it 'returns 2-?' do
        expect(game.playtime_minutes).to eq '2-?'
      end
    end

    context 'when max playtime is 5 and min playtime is not set' do
      let(:game) { Game.new max_playtime_minutes: 5 }
      it 'returns ?-5' do
        expect(game.playtime_minutes).to eq '?-5'
      end
    end

    context 'when min and max playtime is set to 3' do
      let(:game) { Game.new min_playtime_minutes: 3, max_playtime_minutes: 3 }
      it 'returns 3' do
        expect(game.playtime_minutes).to eq '3'
      end
    end
  end
end
