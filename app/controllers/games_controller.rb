class GamesController < ApplicationController
  def index
    @games = Game.all
    if params[:q].present?

      @games = Game.search(params[:q])
    end
  end

  def show
    @game = Game.find(params[:id])
  end
end
