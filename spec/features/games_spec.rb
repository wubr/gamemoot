# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :feature do
  scenario 'can be added to the database from the new game page' do
    game_name = 'The Hotness'
    visit new_game_path
    fill_in 'game[name]', with: game_name
    click_button('Create Game')
    expect(page).to have_content "'#{game_name}' has been saved to the database."
  end

  scenario "can be removed from the database from the game's page" do
    game_name = 'The Hotness'
    game_to_delete = Game.create!(name: game_name)
    visit games_path(game_to_delete)
    click_link 'Delete'
    expect(page).to have_content "'#{game_name}' has been removed from the database."
  end

  feature 'validation' do
    scenario 'stops an empty name from being saved' do
      visit new_game_path
      click_button('Create Game')
      expect(page.current_path).to eq games_path
      expect(page).to have_content "Name can't be blank"
    end

    scenario 'stops a duplicate from being entered' do
      existing_game = Game.create!(name: 'The Hotness 2: None like it hot', bgg_game_id: 12_345)
      visit new_game_path
      fill_in 'game[name]', with: existing_game.name
      fill_in 'game[bgg_game_id]', with: existing_game.bgg_game_id
      click_button('Create Game')
      expect(page.current_path).to eq games_path
      expect(page).to have_content 'Name has already been taken'
      expect(page).to have_content 'BGG Game ID has already been taken'
    end
  end
end
