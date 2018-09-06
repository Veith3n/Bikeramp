require 'rails_helper'
require 'support/trip_repository_mock'

RSpec.describe TripStats do
  context '#monthly_stats' do
    it 'return correctly sorted data' do
      repository = TripRepositoryMock

      monthly_stats = TripStats.new(repository).monthly_stats('total_distance', 'desc')

      expect(monthly_stats.size).to eq(3)

      expect(monthly_stats.first[:day]).to eq(Date.current.beginning_of_month)
      expect(monthly_stats.first[:total_distance].to_f).to eq(70)
      expect(monthly_stats.first[:avg_ride].to_f).to eq(35)
      expect(monthly_stats.first[:avg_price].to_f).to eq(15)

      expect(monthly_stats.last[:day]).to eq(Date.current.end_of_month.yesterday)
    end
  end

  context '#weekly_stats' do
    it 'return correct data' do
      repository = TripRepositoryMock

      weekly_stats = TripStats.new(repository).weekly_stats

      expect(weekly_stats[:total_distance].to_f).to eq(30)
      expect(weekly_stats[:total_price].to_f).to eq(40)
    end
  end
end
