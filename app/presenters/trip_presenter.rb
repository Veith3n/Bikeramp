module TripPresenter
  module_function

  def weekly_stats_serialized(weekly_hash)
    {
      total_distance: "#{serialize_number(weekly_hash[:total_distance])}km",
      total_price: "#{serialize_number(weekly_hash[:total_price])}PLN"
    }
  end

  def monthly_stats_serialized(monthly_hash)
    monthly_hash.map do |result|
      { day: result[:day].strftime("%B, #{result[:day].day.ordinalize}"),
        total_distance: "#{serialize_number(result[:total_distance])}km",
        avg_ride: "#{serialize_number(result[:avg_ride])}km",
        avg_price: "#{serialize_number(result[:avg_price])}PLN" }
    end
  end

  def serialize_number(number)
    number_with_precision(number, precision: 2, strip_insignificant_zeros: true)
  end
end
