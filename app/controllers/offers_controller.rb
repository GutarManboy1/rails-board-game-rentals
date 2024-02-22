class OffersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def show
    @booking = Booking.new
    @offer = Offer.find(params[:id])
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = current_user
    @offer.pending_request = false
    if @offer.save
      redirect_to bookings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

private

  def offer_params
    params.require(:offer).permit(:comment, :price, :picture, :user, :game_id)
  end

end
