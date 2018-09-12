require 'rails_helper'

RSpec.describe Trip, type: :model do
  context '#weekly_scope' do
    before do
      Trip.skip_callback(:validation, :after, :set_date, raise: false)
    end

    let!(:last_year_trip) do
      create(:trip, date: 1.year.ago)
    end

    let!(:first_day_of_current_week) do
      create(:trip, date: Date.current.beginning_of_week)
    end

    let!(:last_day_of_current_week) do
      create(:trip, date: Date.current.end_of_week)
    end

    it 'returns trips from current week' do
      weekly_trips = Trip.weekly

      expect(weekly_trips.first).to eq(first_day_of_current_week)
      expect(weekly_trips.size).to eq(2)
    end
  end

  context '#monthly_scope' do
    before do
      Trip.skip_callback(:validation, :after, :set_date, raise: false)
    end

    let!(:last_year_trip) do
      create(:trip, date: 1.year.ago)
    end

    let!(:current_month_trip) do
      create(:trip, date: Date.current.end_of_month)
    end

    it 'returns trips from current month' do
      monthly_trips = Trip.monthly

      expect(monthly_trips.first).to eq(current_month_trip)
      expect(monthly_trips.size).to eq(1)
    end
  end
end
