# frozen_string_literal: true

# Controls actions relating to Game objects
class GamesController < ApplicationController
  before_action :set_game, only: %i[show edit update destroy]

  # GET /games
  def index
    @games = Game.all
  end

  # GET /games/1
  def show; end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit; end

  # POST /games
  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to @game, notice: "'#{@game.name}' has been saved to the database."
    else
      render :new
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      redirect_to @game, notice: "'#{@game.name}' was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
    redirect_to games_url, notice: "'#{@game.name}' has been removed from the database."
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:name, :bgg_game_id)
  end
end
