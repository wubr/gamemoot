# frozen_string_literal: true

class AddPlayTimeToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :min_playtime_minutes, :integer
    add_column :games, :max_playtime_minutes, :integer
  end
end
