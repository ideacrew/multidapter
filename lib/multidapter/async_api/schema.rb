# frozen_string_literal: true

# Allows the definition of input and output data types. These types can be objects, 
# but also primitives and arrays. This object is a superset of the 
# JSON Schema Specification Draft 07

module Multidapter
  module AsyncApi
    class Schema < Dry::Struct

      attribute :key,   Types::Symbol
      attribute :value, Types::Any

    end
  end
end
