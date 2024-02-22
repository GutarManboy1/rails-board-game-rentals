class OffersController < ApplicationController
  def show
    @booking = Booking.new
    @offer = Offer.find(params[:id])
  end

  def new
  end

  def create
  end
  
end
