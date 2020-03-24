# frozen_string_literal true

module Multidapter

  # A map between a variable name and its value. The value is used for substitution in the server’s URL template
  class Variable < Dry::Struct

    # @!attribute [r] key
    # The variable name
    # @return [Symbol]
    attribute :key,         Types::Symbol

    # @!attribute [r] value
    # Attributes of this variable
    # @return [Multidapter::ServerVariable]
    attribute :value,       Multidapter::ServerVariable

  end
end
