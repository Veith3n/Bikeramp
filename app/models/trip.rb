class Trip < ApplicationRecord
  validates_presence_of :start_address, :destination_address, :price

end
