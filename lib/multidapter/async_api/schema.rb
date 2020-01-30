# frozen_string_literal: true

module Multidapter
  module AsyncApi

    # Allows the definition of input and output data types. These types can be objects,
    # but also primitives and arrays. This object is a superset of the
    # JSON Schema Specification Draft 07

    # @todo Add support for AsyncAPI Schema Object
    class Schema < Dry::Struct

      attribute :key,   Types::Symbol
      attribute :value, Types::Any

    end
  end
end
