class BookingsController < ApplicationController
  def index
    @bookings_as_borrower = Booking.where(user: current_user)
    @bookings_as_owner = []
  end
end
