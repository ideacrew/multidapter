# frozen_string_literal true

module Multidapter
  module AsyncApi
    class Variable < Dry::Struct

      # The vairable name
      attribute :key,         Types::Symbol

      # Attributes of this variable
      attribute :value,       Multidapter::AsyncApi::ServerVariable

    end
  end
end