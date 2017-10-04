# frozen_string_literal: true

class CreateGameTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :games_tables

    create_table :game_tables do |t|
      t.integer :game_id
      t.integer :table_id

      t.timestamps

      t.index :game_id
      t.index :table_id
    end
  end
end
