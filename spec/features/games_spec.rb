# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :feature do
  scenario 'can be added to the database from the new game page' do
    game_name = 'The Hotness'
    visit new_game_path
    fill_in :name, with: game_name
    click_button('Submit')
    expect(page).to have_content "'#{game_name}' has been saved to the database."
  end

  scenario "can be removed from the database from the game's page" do
    game_name = 'The Hotness'
    game_to_delete = Game.create!(name: game_name)
    visit games_path(game_to_delete)
    click_button 'Delete game'
    expect(page).to have_content "'#{game_name}' has been removed from the database."
  end

  feature 'validation' do
    scenario 'stops an empty name from being saved' do
      visit new_game_path
      click_button('Submit')
      expect(page.current_path).to eq new_game_path
      expect(page).to have_content "Your form contained errors."
    end

    scenario 'stops a duplicate from being entered' do
      game_name = 'The Hotness 2: None like it hot'
      bgg_game_id = 12345
      existing_game = Game.create!(name: game_name, bgg_game_id: bgg_game_id)
      visit new_game_path
      fill_in :name, with: game_name
      fill_in :bgg_game_id, with: bgg_game_id
      click_button('Submit')
      expect(page.current_path).to eq new_game_path
      expect(page).to have_content "name has already been taken."
      expect(page).to have_content "bgg_id has already been taken"
    end
  end
end
