# frozen_string_literal true
# An object representing a Server Variable for server URL template substitution.

module Multidapter
  module AsyncApi
    class ServerVariable < Dry::Struct

      # An enumeration of string values to be used if the substitution options are from a limited set
      attribute :enum,        Types::Array.of(String).meta(omittable: true)

      # The default value to use for substitution, and to send, if an alternate value is not supplied
      attribute :default,     Types::String.meta(ommittable: true)

      # An optional description for the server variable. CommonMark syntax MAY be used for rich text representation
      attribute :description, Types::String.meta(ommittable: true)

      # An array of examples of the server variable
      attribute :examples,    Types::Array.of(String).meta(omittable: true)

    end
  end
end