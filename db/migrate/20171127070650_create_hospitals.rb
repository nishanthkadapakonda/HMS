class CreateHospitals < ActiveRecord::Migration[5.1]
  def change
    create_table :hospitals do |t|
      t.string :name
      t.string :place
      t.string :pin
      t.string :phone

      t.timestamps
    end
  end
end
