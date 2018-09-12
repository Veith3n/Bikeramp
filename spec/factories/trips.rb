FactoryBot.define do
  factory :trip do
    start_address { 'Miodowa 1, Warszawa' }
    destination_address { 'Nowogordzka 1, Warszawa' }
    date { Date.current }
    price { 10 }
  end
end
