class BookingsController < ApplicationController
  def index
    @bookings_as_borrower = Booking.where(user: current_user)
    @bookings_as_owner = Offer.where(user: current_user)
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to bookings_path
    else
      render :new, :unprocessable_entity
    end
  end

  def create
    @offer = Offer.find(params["offer_id"])
    @booking = Booking.new(booking_params)

    @booking.user = current_user
    @booking.offer = @offer

    if @booking.save
      redirect_to bookings_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:status, :start_date, :end_date)
  end
end
