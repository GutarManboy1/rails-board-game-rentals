class Game < ApplicationRecord
  has_many :users, through: :offers
  has_many :offers
end
