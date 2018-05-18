# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GameTable', type: :feature do
  before do
    @table = Table.create!(name: 'Our Table')
    @game = Game.create!(name: 'Our Game',
                         max_players: 5,
                         min_players: 2,
                         min_playtime_minutes: 30,
                         max_playtime_minutes: 90)
  end

  scenario 'setting a game on a table' do
    visit table_path(@table)
    select @game.name, from: 'Available Games'
    click_button('Add Game')

    within('table#to-play') do
      expect(page).to have_content @game.name
      expect(page).to have_content @game.players_supported
      expect(page).to have_content @game.playtime_minutes
    end
  end

  scenario 'removing a game from a table' do
    game_table = GameTable.create!(table: @table, game: @game)
    visit table_path(@table)
    within(:css, "tr#game_table_#{game_table.id}") do
      click_link('Remove')
    end
    expect(page).to have_content 'has been removed from the table'
    within(:css, 'table#to-play') do
      expect(page).not_to have_content @game.name
    end
  end
end
