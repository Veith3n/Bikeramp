FactoryBot.define do
  factory :trip do
    sequence(:start_address) { |n| "Miodowa #{n}, Warszawa" }
    sequence(:destination_address) { |n| "Nowogordzka #{n}, Warszawa" }
    date Date.current
    price 10
  end
end
