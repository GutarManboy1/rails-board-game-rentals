class OffersController < ApplicationController
  def show
    @offers = Offer.all
  end
end
