# frozen_string_literal: true

# Add initial games to work with, skipping validation to prevent api calls
Game.new(name: "Memoir '44", bgg_game_id: 10_630).save(validate: false)
Game.new(name: 'In a Grove', bgg_game_id: 102_181).save(validate: false)
Game.new(name: 'Mysterium', bgg_game_id: 181_304).save(validate: false)
Game.new(name: 'Suburbia', bgg_game_id: 123_260).save(validate: false)
Game.new(name: 'Inis', bgg_game_id: 155_821).save(validate: false)
