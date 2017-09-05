# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Table, type: :feature do
  scenario 'can be created from the home page' do
    table_name = 'My Table'
    visit root_path
    fill_in 'table[name]', with: table_name
    click_link('Create Table')
    expect(page).to have_content "'#{table_name}' has been successfully created."
  end

  scenario 'can be cancelled from its own page' do
    table_to_cancel = Table.create(name: 'My Table')
    visit table_path(table_to_cancel)
    click_link 'Cancel'
    expect(page).to have_content "'#{table_to_cancel.name}' has been cancelled."
  end

  feature 'validation' do
    scenario 'makes sure the Table has a name' do
      visit root_path
      click_link('Create Table')
      expect(page).to have_content "Name can't be blank"
    end
  end
end
