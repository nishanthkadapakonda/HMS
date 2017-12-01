class ChangeDataTypeOfTimeSlotInInterval < ActiveRecord::Migration[5.1]
  def change
    change_column :intervals, :timeslot, :string
  end
end
