module TripStats
  module_function

  def weekly_stats
    weekly_trips = Trip.weekly
    {
      total_distance: weekly_trips.sum(&:distance),
      total_price: weekly_trips.sum(&:price)
    }
  end

  def monthly_stats(orderParam, orderType)
    orderParam.nil? || orderParam == '' ? orderParam = 'day' : ''
    orderType.nil? ? orderType = 'asc' : ''

    monthly_hash = Trip.monthly.group_by(&:date).map do |result|
      { day: result[0],
        total_distance: result[1].sum(&:distance),
        avg_ride: average_distance(result),
        avg_price: average_price(result) }
    end
    orderType == 'asc' ? monthly_hash.sort_by { |result| result[orderParam.to_sym] } : monthly_hash.sort_by { |result| result[orderParam.to_sym] }.reverse
  end

  def average_distance(trip)
    trip[1].sum(&:distance) / trip[1].size
  end

  def average_price(trip)
    trip[1].sum(&:price) / trip[1].size
  end
end
