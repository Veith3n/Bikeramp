class AddDistanceToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :distance, :decimal, precision: 5, scale: 2
  end
end
