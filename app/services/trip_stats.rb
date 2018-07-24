module TripStats

  module_function

  def monthly_stats
    Trip.monthly.group_by(&:date).map { |result| { day: result[0].strftime("%B, #{result[0].day.ordinalize}"),
                                                   total_distance: "#{number_with_precision(result[1].sum(&:distance), precision: 2, strip_insignificant_zeros: true)}km",
                                                   avg_ride: "#{number_with_precision(calculate_average(result[1].sum(&:distance), result[1].size), precision: 2, strip_insignificant_zeros: true)}km",
                                                   avg_price: "#{number_with_precision(calculate_average(result[1].sum(&:price), result[1].size), precision: 2, strip_insignificant_zeros: true)}PLN" } }
  end

  def calculate_average(sum, count)
    sum / count
  end
end