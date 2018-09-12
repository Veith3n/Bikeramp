class TripRepositoryMock
  def self.monthly
    [
      FactoryBot.build(:trip, date: Date.current.beginning_of_month, distance: 50),
      FactoryBot.build(:trip, date: Date.current.beginning_of_month, price: 20, distance: 20),
      FactoryBot.build(:trip, date: Date.current.end_of_month.yesterday, distance: 1),
      FactoryBot.build(:trip, date: Date.current.end_of_month, distance: 15)
    ]
  end

  def self.monthly_grouped_by_date
    {
      Date.current.beginning_of_month =>

        [FactoryBot.build(:trip, date: Date.current.beginning_of_month, price: 10, distance: 50),
         FactoryBot.build(:trip, date: Date.current.beginning_of_month, price: 20, distance: 20)],
      Date.current.end_of_month.yesterday =>
        [FactoryBot.build(:trip, date: Date.current.end_of_month.yesterday, distance: 1)],
      Date.current.end_of_month =>
        [FactoryBot.build(:trip, date: Date.current.end_of_month, distance: 15)]
    }
  end

  def self.weekly
    [
      FactoryBot.build(:trip, date: Date.current.beginning_of_week, distance: 10),
      FactoryBot.build(:trip, date: Date.current.beginning_of_week, price: 20, distance: 10),
      FactoryBot.build(:trip, date: Date.current.end_of_week, distance: 10)
    ]
  end

  def self.weekly_stats
    {
      total_distance: 50.0001, total_price: 100
    }
  end

  def self.monthly_stats
    [
      { day: Date.current.beginning_of_month, total_distance: 3.620001, avg_ride: 1.8111, avg_price: 15 },
      { day: Date.current.end_of_month, total_distance: 2, avg_ride: 4, avg_price: 3 }
    ]
  end
end
