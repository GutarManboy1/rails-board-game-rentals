class BookingsController < ApplicationController
  def index
    @bookings_as_borrower = Booking.where(user: current_user)
    @bookings_as_owner = []
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def create
    @offer = Offer.find(params["offer_id"])
    @booking = Booking.new(booking_params)

    @booking.user = current_user
    @booking.offer = @offer

    if @booking.save
      redirect_to bookings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
