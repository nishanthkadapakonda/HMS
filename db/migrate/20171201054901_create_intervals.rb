class CreateIntervals < ActiveRecord::Migration[5.1]
  def change
    create_table :intervals do |t|
      t.references :slot, foreign_key: true
      t.time :timeslot

      t.timestamps
    end
  end
end
