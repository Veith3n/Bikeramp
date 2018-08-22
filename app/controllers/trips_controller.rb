class TripsController < ApplicationController
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.create(trip_params)
  end

  def weekly
    render json: TripStats.weekly_stats.to_json
  end

  def monthly
    render json: TripStats.monthly_stats.to_json
  end

  def trip_params
    params.require(:trip).permit(:start_address, :destination_address, :price)
  end
end
