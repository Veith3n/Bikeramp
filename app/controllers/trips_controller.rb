class TripsController < ApplicationController
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.create(trip_params)
  end

  def weekly
    headers = [['total_distance', 'total_price']]
    render json: Trip.weekly_stats.map(&headers.first.method(:zip)).map(&:to_h).to_json
  end

  def trip_params
    params.require(:trip).permit(:start_address, :destination_address, :price)
  end
end
