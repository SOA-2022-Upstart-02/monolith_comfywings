# frozen_string_literal: false

require 'dry-struct'
require 'dry-types'

require_relative 'flight'

module ComfyWings
  module Entity
    # class for trip entities
    class Trip < Dry::Struct
      include Dry.Types

      attribute :id,              Integer.optional
      attribute :origin,          Strict::String
      attribute :destination,     Strict::String
      attribute :price,           Strict::String
      #attribute :oneWay,          Strict::Bool
      attribute :flights,         Strict::Array.of(Flight)

      def to_attr_hash
        to_hash.except(:id)
      end
    end
  end
end
