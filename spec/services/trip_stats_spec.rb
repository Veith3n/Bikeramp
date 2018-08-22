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

    let!(:last_day_of_current_moth) do
      create(:trip, date: Date.current.end_of_month)
    end

    it 'return correct data' do
      monthly_stats = TripStats.monthly_stats

      expect(monthly_stats.size).to eq(2)

      expect(monthly_stats.first[:day]).to eq(Date.current.beginning_of_month.strftime("%B, #{Date.current.beginning_of_month.day.ordinalize}"))
      expect(monthly_stats.first[:total_distance]).to eq('3.95km')
      expect(monthly_stats.first[:avg_ride]).to eq('1.98km')
      expect(monthly_stats.first[:avg_price]).to eq('15PLN')

      expect(monthly_stats.last[:day]).to eq(Date.current.end_of_month.strftime("%B, #{Date.current.end_of_month.day.ordinalize}"))
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

      expect(weekly_stats[:total_distance]).to eq('6.12km')
      expect(weekly_stats[:total_price]).to eq('40PLN')
    end
  end
end
