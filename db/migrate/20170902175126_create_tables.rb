# frozen_string_literal: true

class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :tables do |t|
      t.string :name, null: false
      t.datetime :starts_at
      t.integer :max_seats, default: 0
      t.text :comments
      t.text :requirements
      t.timestamps
    end
  end
end
