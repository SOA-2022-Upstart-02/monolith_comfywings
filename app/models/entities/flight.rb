# frozen_string_literal: false

require 'dry-struct'
require 'dry-types'
require 'active_support'
require 'active_support/core_ext/date/calculations'

module ComfyWings
  module Entity
    # class for flight entitity
    class Flight < Dry::Struct
      include Dry.Types

      attribute :id,              Integer.optional
      attribute :trip_id,         Integer.optional
      attribute :origin,          Strict::String
      attribute :destination,     Strict::String
      attribute :departure_time,  Strict::String
      attribute :arrival_time,    Strict::String
      attribute :duration,        Strict::String
      attribute :aircraft,        Strict::String
      attribute :number,          Strict::String
      attribute :cabin_class,     Strict::String
      attribute :is_return,       Strict::Bool

      def to_attr_hash
        to_hash.except(:id, :trip_id)
      end

      def duration_form
        ActiveSupport::Duration.parse(duration).parts
      end
    end
  end
end
