class CreateDoctors < ActiveRecord::Migration[5.1]
  def change
    create_table :doctors do |t|
      t.string :specialization
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
