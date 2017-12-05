class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :slot
  belongs_to :hospital
  belongs_to :doctor
  def self.update_is_available_to_true booking
    updateSlot = Slot.where(:id => booking.slot_id).first
    updateInterval = Interval.where(:slot_id => updateSlot.id , :id => booking.slot_time)
    updateInterval.first.is_available = false
    return updateSlot , updateInterval.first
  end
end
