# frozen_string_literal true
# An object representing a Server Variable for server URL template substitution.

module Multidapter
  module AsyncApi

    # An object representing a Server Variable for server URL template substitution
    class ServerVariable < Dry::Struct

      # @!attribute [r] enum
      # An enumeration of string values to be used if the substitution options are from a limited set
      # @return [Array<String>]
      attribute :enum,        Types::Array.of(String).meta(omittable: true)

      # @!attribute [r] default
      # The default value to use for substitution, and to send, if an alternate value is not supplied
      # @return [String]
      attribute :default,     Types::Coercible::String.meta(ommittable: true)

      # @!attribute [r] description
      # An optional description for the server variable. CommonMark syntax MAY be used for rich text representation
      # @return [String]
      attribute :description, Types::String.meta(ommittable: true)

      # @!attribute [r] examples
      # An array of examples of the server variable
      # @return [Array<String>]
      attribute :examples,    Types::Array.of(String).meta(omittable: true)

    end
  end
end