module TripStats
  module_function

  def weekly_stats
    weekly_trips = Trip.weekly
    {
      total_distance: "#{serialize_number(weekly_trips.sum(&:distance))}km",
      total_price: "#{serialize_number(weekly_trips.sum(&:price))}PLN"
    }
  end

  def monthly_stats
    Trip.monthly.group_by(&:date).map do |result|
      { day: result[0].strftime("%B, #{result[0].day.ordinalize}"),
        total_distance: "#{serialize_number(result[1].sum(&:distance))}km",
        avg_ride: "#{serialize_number(average_distance(result))}km",
        avg_price: "#{serialize_number(average_price(result))}PLN" }
    end
  end

  def average_distance(trip)
    trip[1].sum(&:distance) / trip[1].size
  end

  def average_price(trip)
    trip[1].sum(&:price) / trip[1].size
  end

  def serialize_number(number)
    number_with_precision(number, precision: 2, strip_insignificant_zeros: true)
  end
end