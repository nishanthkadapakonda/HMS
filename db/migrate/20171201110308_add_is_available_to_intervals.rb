class AddIsAvailableToIntervals < ActiveRecord::Migration[5.1]
  def change
    add_column :intervals, :is_available, :boolean
  end
end
