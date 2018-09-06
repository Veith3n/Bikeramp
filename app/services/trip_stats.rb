class TripRepository
  delegate :weekly, :monthly_grouped_by_date, to: Trip
end

class TripStats
  def initialize(trip_repository = TripRepository.new)
    @trip_repository = trip_repository
  end

  def weekly_stats
    weekly_trips = @trip_repository.weekly
    {
      total_distance: weekly_trips.sum(&:distance),
      total_price: weekly_trips.sum(&:price)
    }
  end

  def monthly_stats(order_param, order_type)
    order_param.nil? || order_param == '' ? order_param = 'day' : ''
    order_type.nil? ? order_type = 'asc' : ''

    monthly_hash = @trip_repository.monthly_grouped_by_date.map do |day, trips|
      {
        day: day,
        total_distance: trips.sum(&:distance),
        avg_ride: average_distance(trips),
        avg_price: average_price(trips) }
    end
    monthly_hash = monthly_hash.sort_by { |trip| trip[order_param.to_sym] }
    order_type == 'asc' ? monthly_hash : monthly_hash.reverse
  end

  private

  def average_distance(trips)
    trips.sum(&:distance) / trips.size
  end

  def average_price(trips)
    trips.sum(&:price) / trips.size
  end
end
