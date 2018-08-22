Trip.destroy_all

streets = %w(Marszalkowska Pulawska Miodowa Twarda Obozna Poznanska Stawy)

20.times do
  starting_point = "#{streets.sample} #{rand(0..20)}, Warszawa"
  end_point = "#{streets.sample} #{rand(21..50)}, Warszawa"

  trip = Trip.new(start_address: starting_point, destination_address: end_point, distance: rand(1..30), date: rand(1..30).days.ago, price: rand(1..150))
  trip.save(validate: false)
  print '.'
end

10.times do
  starting_point = "#{streets.sample} #{rand(0..20)}, Warszawa"
  end_point = "#{streets.sample} #{rand(21..50)}, Warszawa"

  trip = Trip.new(start_address: starting_point, destination_address: end_point, distance: rand(1..30), date: Date.current, price: rand(1..150))
  trip.save(validate: false)
  print '.'
end

puts ' '
puts 'Trips generated'
