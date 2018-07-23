require 'rails_helper'

RSpec.describe Trip, type: :model do

  context '#scopes', vcr: 'address_cords' do
    before do
      Trip.skip_callback(:validation, :after, :set_date, raise: false)
    end

    let!(:last_year_trip) do
      Trip.create(start_address: 'Miodowa 5', destination_address: 'Nowogrodzka 40', date: 1.year.ago, price: 10)
    end

    let!(:last_month_trip) do
      Trip.create(start_address: 'Zelazna 5', destination_address: 'Popularna 40', date: Date.current.beginning_of_month, price: 10)
    end

    let!(:first_day_of_current_week) do
      Trip.create(start_address: 'Pulawska 5', destination_address: 'Lazurowa 40', date: Date.current, price: 10)
    end

    let!(:last_day_of_current_week) do
      Trip.create(start_address: 'Pulawska 5', destination_address: 'Lazurowa 40', date: Date.current, price: 10)
    end

    it 'returns trips from current week' do
      weekly_trips = Trip.weekly

      expect(weekly_trips.first).to eq(first_day_of_current_week)
      expect(weekly_trips.size).to eq(2)
    end

    it 'returns correct distance and price for current week' do
      weekly_stats = Trip.weekly_stats

      expect(weekly_stats.first.first).to eq(40.28)
      expect(weekly_stats.first.last).to eq(20)
    end
  end
end
