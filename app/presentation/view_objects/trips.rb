# frozen_string_literal: true

module Views
  #class for trip info
  class Trips
    def initialize(trip)
      @trip = trip
    end
  
    def origin
      @trip.origin
    end
  
    def destination
      @flight.destination
    end

    def flights
      @trip.flights
    end
  end
end