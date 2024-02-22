class Offer < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :bookings
  has_one_attached :photo

  def pending_bookings?
    bookings.where(status: "Pending").count.positive?
  end
end
