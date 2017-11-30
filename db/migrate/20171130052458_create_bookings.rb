class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.references :slot, foreign_key: true
      t.references :hospital, foreign_key: true
      t.references :doctor, foreign_key: true
      t.string :illness
      t.string :symptoms
      t.string :observation
      t.boolean :status, :default => false

      t.timestamps
    end
  end
end
