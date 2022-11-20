# frozen_string_literal: false

# require_relative 'flight_mapper'

module ComfyWings
    module Amadeus
      # Data Mapper: Amadeus Flight-offer -> Trip entity
      class TripQueryMapper
        def initialize(key, secret, gateway_class = ComfyWings::Amadeus::Api)
          @key = key
          @secret = secret
          @gateway_class = gateway_class
          @gateway = @gateway_class.new(@key, @secret)
        end
  
        def search(from, to, from_date, to_date)
          #data = @gateway.trip_data(from, to, from_date, to_date)
          TripQueryMapper.build_entity(from, to)
        end
  
        def self.build_entity(from, to)
          TripQueryDataMapper.new(from, to).build_entity
        end
  
        # Extracts entity specific elements from data structure
        class TripQueryDataMapper
          def initialize(from, to)
            @from = from
            @to = to
          end
  
          def build_entity
            ComfyWings::Entity::TripQuery.new(
              id: nil,
              origin:,
              destination:,
              #oneWay:,
              #code:,           
              #currency:,       
              #departure_date:, 
              #arrival_date:,   
              #adult_qty:,      
              #children_qty:,
            )
          end
  
          def origin
            @from
          end
  
          def destination
            @to
          end
        end
      end
    end
  end
  