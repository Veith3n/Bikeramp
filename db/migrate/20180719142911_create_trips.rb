class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :start_address
      t.string :destination_address
      t.decimal :price, precision: 5, scale: 2
      t.date :date

      t.timestamps
    end
  end
end
