# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :name, null: false
      t.integer :bgg_game_id
      t.integer :min_players
      t.integer :max_players

      t.timestamps
    end
    add_index :games, :name, unique: true
    add_index :games, :bgg_game_id, unique: true
  end
end
