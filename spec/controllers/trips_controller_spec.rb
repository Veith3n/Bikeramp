require 'rails_helper'

RSpec.describe TripsController, type: :controller do

  context '#create' do
    it 'create trip with valid params' do
      params = { start_address: 'Wiejska 6, Warszawa', destination_address: 'Nowy Swiat 6, Warszawa', price: 10.2 }

      post :create, params: { trip: params }

      expect(Trip.last.start_address).to eq(params[:start_address])
      expect(Trip.last.destination_address).to eq(params[:destination_address])
    end
    it 'does not create trip with missing params' do
      params = { starting_point: 'Wiejska 6, Warszawa', end_point: nil }

      expect {post :create, params: { trip: params }}.to_not change {Trip.count}
    end
  end
end