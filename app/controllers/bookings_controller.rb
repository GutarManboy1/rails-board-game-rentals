class BookingsController < ApplicationController
  def index
    @bookings_as_borrower = current_user.bookings
    @bookings_as_owner = current_user.bookings_as_owner
    @offers = current_user.offers
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
    # manually setting dates for flatpickr
    @booking.start_date = params[:booking][:start_date].split(" to ").first
    @booking.end_date = params[:booking][:start_date].split(" to ").last
    @booking.user = current_user
    @booking.offer = @offer

    if @booking.save
      @offer.pending_request = true
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
