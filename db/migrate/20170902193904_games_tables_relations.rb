# frozen_string_literal: true

class GamesTablesRelations < ActiveRecord::Migration[5.1]
  def change
    create_join_table :games, :tables do |t|
      t.index :game_id
      t.index :table_id
    end
  end
end
