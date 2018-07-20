class TripsController < ApplicationController
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.create(trip_params)
  end

  def trip_params
    params.require(:trip).permit(:start_address, :destination_address, :price)
  end
end
