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

  def destroy
    game_table.destroy
    redirect_to game_table.table, notice: "'#{game_table.game.name}' has been removed from the table."
  end

  private

  def table_params
    params.require(:game_table).permit(:game_id, :table_id)
  end

  def game_table
    @game_table ||= GameTable.find(params[:id])
  end
end
