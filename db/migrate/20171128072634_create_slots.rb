class CreateSlots < ActiveRecord::Migration[5.1]
  def change
    create_table :slots do |t|
      t.references :user, foreign_key: true
      t.references :hospital, foreign_key: true
      t.date :date
      t.string :time_in
      t.string :time_out
      t.integer :no_of_patients

      t.timestamps
    end
  end
end
