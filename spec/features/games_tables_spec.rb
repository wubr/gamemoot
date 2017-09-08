# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GameTable', type: :feature do
  before do
    @table = Table.create!(name: 'Our Table')
    @game = Game.create!(name: 'Our Game')
  end

  scenario 'setting a game on a table' do
    visit table_path(@table)
    select @game.name, from: 'Available Games'
    click_button('Add Game')

    within('table#to-play') do
      expect(page).to have_content @game.name
    end
  end

  scenario 'removing a game from a table' do
    @table.games << @game
    visit table_path(@table)
    click_button('Remove Game')
    within('table#to-play') do
      expect(page).not_to have_content @game.name
    end
  end

  scenario 'putting a game on a table multiple times'
end
