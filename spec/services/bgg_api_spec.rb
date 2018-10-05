# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BggApi do
  describe '::game_info', :vcr do
    context 'with an ID that exists' do
      let(:bgg_id) { 169_786 } # Scythe

      before do
        @game_info = BggApi.game_info(bgg_id)
      end

      it "includes the game's name in the returned object" do
        expect(@game_info[:name]).to eq 'Scythe'
      end

      it "includes the game's minimum players in the returned object" do
        expect(@game_info[:min_players]).to eq 1
      end

      it "includes the game's maximum players in the returned object" do
        expect(@game_info[:max_players]).to eq 5
      end

      it "includes the game's minimum playtime in the returned object" do
        expect(@game_info[:min_playtime_minutes]).to eq 90
      end

      it "includes the game's maximum playtime in the returned object" do
        expect(@game_info[:max_playtime_minutes]).to eq 115
      end
    end

    context 'with an invalid ID' do
      let(:bgg_id) { -1 } # Scythe

      it 'raises BggGameInfoNotFound' do
        expect { @game_info = BggApi.game_info(bgg_id) }.to raise_error Gamemoot::Errors::BggGameInfoNotFound
      end
    end

    context 'when the BGG API returns an error' do
      before do
        response = RestClient::Response.new('Oh bother')
        exception = RestClient::ExceptionWithResponse.new(500, response)
        allow(RestClient).to receive(:get).and_raise exception
      end

      it 'raises the BggApiError exception' do
        expect { BggApi.game_info(1) }.to raise_error Gamemoot::Errors::BggApiError
      end
    end
  end

  describe '::game_search', :vcr do
    context 'when :type is not specified' do
      context 'and :name should return search results' do
        let(:name_parameter) { 'Scyt' }

        before do
          @results = BggApi.game_search(name: name_parameter)
        end

        it "returns results' names" do
          expect(@results.first[:name]).not_to be nil
        end

        it "returns results' thing IDs" do
          expect(@results.first[:bgg_game_id].to_i).to be_an Integer
        end

        it "returns results' year published" do
          expect(@results.first[:published]).not_to be nil
        end

        it 'returns search results' do
          expect(@results.count).to eq 17
        end

        it 'returns an array' do
          expect(@results).to be_an Array
        end
      end

      context 'and :name does not return search results' do
        let(:name_parameter) { 'wubr' }

        before do
          @results = BggApi.game_search(name: name_parameter)
        end

        it 'returns an empty array' do
          expect(@results).to eq []
        end
      end
    end

    context 'when the BGG API returns an error' do
      before do
        response = RestClient::Response.new('Oh bother')
        exception = RestClient::ExceptionWithResponse.new(500, response)
        allow(RestClient).to receive(:get).and_raise exception
      end

      it 'raises the BggApiError exception' do
        expect { BggApi.game_search(name: 'name') }.to raise_error Gamemoot::Errors::BggApiError
      end
    end
  end
end
