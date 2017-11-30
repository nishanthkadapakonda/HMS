class AddDoctorToSlots < ActiveRecord::Migration[5.1]
  def change
    add_reference :slots, :doctor, foreign_key: true
  end
end
