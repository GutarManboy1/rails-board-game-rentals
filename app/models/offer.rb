class Offer < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :bookings
end
