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
end
