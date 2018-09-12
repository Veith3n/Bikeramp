require 'rails_helper'
require 'support/trip_repository_mock'

RSpec.describe TripPresenter do
  context '#monthly_stats_serialized' do
    it 'return correct data' do
      monthly_hash = TripRepositoryMock.monthly_stats
      monthly_stats = TripPresenter.monthly_stats_serialized(monthly_hash)

      expect(monthly_stats.size).to eq(2)

      expect(monthly_stats.first[:day]).to eq(Date.current.beginning_of_month.strftime("%B, #{Date.current.beginning_of_month.day.ordinalize}"))
      expect(monthly_stats.first[:total_distance]).to eq('3.62km')
      expect(monthly_stats.first[:avg_ride]).to eq('1.81km')
      expect(monthly_stats.first[:avg_price]).to eq('15PLN')

      expect(monthly_stats.last[:day]).to eq(Date.current.end_of_month.strftime("%B, #{Date.current.end_of_month.day.ordinalize}"))
    end
  end

  context '#weekly_stats_serialized' do
    it 'return correctly formatted data' do
      weekly_hash = TripRepositoryMock.weekly_stats
      weekly_stats = TripPresenter.weekly_stats_serialized(weekly_hash)

      expect(weekly_stats[:total_distance]).to eq('50km')
      expect(weekly_stats[:total_price]).to eq('100PLN')
    end
  end
end
