class Game < ApplicationRecord
  include PgSearch::Model
  has_many :users, through: :offers
  has_many :offers

  pg_search_scope :search,
                  against: [:name, :description],
                  using: {
                    tsearch: { prefix: true },
                  }
end
