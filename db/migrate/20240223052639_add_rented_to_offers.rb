class AddRentedToOffers < ActiveRecord::Migration[7.1]
  def change
    add_column :offers, :rented, :boolean, default: false
  end
end
