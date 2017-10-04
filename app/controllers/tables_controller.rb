# frozen_string_literal: true

# Controls actions relating to Table objects
class TablesController < ApplicationController
  before_action :set_table, only: %i[show edit update destroy]
  before_action :games, only: %i[show]
  before_action :game_table, only: %i[show]

  # GET /tables
  # GET /tables.json
  def index
    @tables = Table.all
  end

  # GET /tables/1
  # GET /tables/1.json
  def show; end

  # GET /tables/new
  def new
    @table = Table.new
  end

  # GET /tables/1/edit
  def edit; end

  # POST /tables
  # POST /tables.json
  def create
    @table = Table.new(table_params)

    if @table.save
      redirect_to @table, notice: "'#{@table.name}' has been successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /tables/1
  # PATCH/PUT /tables/1.json
  def update
    if @table.update(table_params)
      redirect_to @table, notice: "'#{@table.name}' has been successfully updated."
    else
      render :edit
    end
  end

  # DELETE /tables/1
  # DELETE /tables/1.json
  def destroy
    @table.destroy
    redirect_to tables_url, notice: "'#{@table.name}' has been cancelled."
  end

  private

  def games
    @games ||= Game.all
  end

  def game_table
    @game_table ||= GameTable.new
  end

  def set_table
    @table = Table.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def table_params
    params.require(:table).permit(:name)
  end
end
