class OffersController < ApplicationController
  def show
    @booking = Booking.new
    @offer = Offer.find(params[:id])
  end
end
