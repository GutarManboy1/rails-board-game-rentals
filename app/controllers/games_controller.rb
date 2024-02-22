class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

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
