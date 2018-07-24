require 'rails_helper'

RSpec.describe TripStats do

  context '#monthly_stats', vcr: 'address_cords' do
    before do
      Trip.skip_callback(:validation, :after, :set_date, raise: false)
    end

    let!(:last_year_trip) do
      Trip.create(start_address: 'Miodowa 5', destination_address: 'Nowogrodzka 40', date: 1.year.ago, price: 10)
    end

    let!(:first_day_of_current_month_10) do
      Trip.create(start_address: 'Pulawska 5', destination_address: 'Lazurowa 40', date: Date.current.beginning_of_month, price: 10)
    end

    let!(:first_day_of_current_month_20) do
      Trip.create(start_address: 'Pulawska 15', destination_address: 'Twarda 40', date: Date.current.beginning_of_month, price: 20)
    end

    let!(:last_day_of_current_moth) do
      Trip.create(start_address: 'Pulawska 5', destination_address: 'Lazurowa 40', date: Date.current.end_of_month, price: 10)
    end

    it 'return correct data' do
      monthly_stats = TripStats.monthly_stats

      expect(monthly_stats.size).to eq(2)

      expect(monthly_stats.first[:day]).to eq(Date.current.beginning_of_month.strftime("%B, #{Date.current.beginning_of_month.day.ordinalize}"))
      expect(monthly_stats.first[:total_distance]).to eq('23.07km')
      expect(monthly_stats.first[:avg_ride]).to eq('11.54km')
      expect(monthly_stats.first[:avg_price]).to eq('15PLN')

      expect(monthly_stats.last[:day]).to eq(Date.current.end_of_month.strftime("%B, #{Date.current.end_of_month.day.ordinalize}"))
    end
  end
end
