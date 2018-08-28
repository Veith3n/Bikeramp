require 'rails_helper'

RSpec.describe TripStats do
  context '#monthly_stats', vcr: 'address_cords' do
    before do
      Trip.skip_callback(:validation, :after, :set_date, raise: false)
    end

    let!(:last_year_trip) do
      create(:trip, date: 1.year.ago)
    end

    let!(:first_day_of_current_month_10) do
      create(:trip, date: Date.current.beginning_of_month)
    end

    let!(:first_day_of_current_month_20) do
      create(:trip, date: Date.current.beginning_of_month, price: 20)
    end

    let!(:ereyesterday_day_of_current_moth) do
      create(:trip, date: Date.current.end_of_month.yesterday)
    end

    let!(:last_day_of_current_moth) do
      create(:trip, date: Date.current.end_of_month, destination_address: 'Nowogordzka 50, Warszawa')
    end

    it 'return correctly sorted data' do
      monthly_stats = TripStats.monthly_stats('total_distance', 'desc')

      expect(monthly_stats.size).to eq(3)

      expect(monthly_stats.first[:day]).to eq(Date.current.beginning_of_month)
      expect(monthly_stats.first[:total_distance].to_f).to eq(3.62)
      expect(monthly_stats.first[:avg_ride].to_f).to eq(1.81)
      expect(monthly_stats.first[:avg_price].to_f).to eq(15)

      expect(monthly_stats.last[:day]).to eq(Date.current.end_of_month.yesterday)
    end
  end

  context '#weekly_stats', vcr: 'address_cords' do
    before do
      Trip.skip_callback(:validation, :after, :set_date, raise: false)
    end

    let!(:last_year_trip) do
      create(:trip, date: 1.year.ago)
    end

    let!(:first_day_of_current_week_10) do
      create(:trip, date: Date.current.beginning_of_week)
    end

    let!(:first_day_of_current_week_20) do
      create(:trip, date: Date.current.beginning_of_week, price: 20)
    end

    let!(:last_day_of_current_week) do
      create(:trip, date: Date.current.end_of_week)
    end

    it 'return correct data' do
      weekly_stats = TripStats.weekly_stats

      expect(weekly_stats[:total_distance].to_f).to eq(5.43)
      expect(weekly_stats[:total_price].to_f).to eq(40)
    end
  end
end
