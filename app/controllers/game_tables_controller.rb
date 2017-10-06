# frozen_string_literal: true

# Handle creation/destruction of GameTable objects
class GameTablesController < ApplicationController
  def create
    @game_table = GameTable.new(table_params)
    table = @game_table.table
    game_name = @game_table.game.name

    if @game_table.save
      redirect_to table, notice: "'#{game_name}' has been successfully added to the table."
    else
      redirect_to table, notice: "Something went wrong while adding '#{game_name}' to the table."
    end
  end

  private

  def table_params
    params.require(:game_table).permit(:game_id, :table_id)
  end
end
