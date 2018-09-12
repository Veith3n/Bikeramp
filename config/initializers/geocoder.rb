Geocoder.configure(units: :km)
Geocoder.configure(always_raise: [Geocoder::OverQueryLimitError, Timeout::Error])
