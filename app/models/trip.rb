class Trip < ApplicationRecord
  validates_presence_of :start_address, :destination_address, :price

  after_validation :calculate_distance, :set_date

  scope :weekly, -> { where(date: Date.current.beginning_of_week..Date.current.end_of_week).order(:date) }
  scope :weekly_stats, -> { Trip.weekly.pluck("sum(distance)", "sum(price)") }
  scope :monthly, -> { where(date: Date.current.beginning_of_month..Date.current.end_of_month).order(:date) }

  def start_cords
    Geocoder.coordinates(start_address)
  end

  def end_cords
    Geocoder.coordinates(destination_address)
  end

  def calculate_distance
    self.distance = Geocoder::Calculations.distance_between(start_cords, end_cords)
  end

  def set_date
    self.date = Date.current
  end
end