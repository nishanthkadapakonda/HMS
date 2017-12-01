class AddSlotTimeToBookings < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :slot_time, :string
  end
end
