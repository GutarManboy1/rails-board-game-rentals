class AddDefaultToStatusInBookings < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :status
    add_column :bookings, :status, :string, default: "Pending"
  end
end
