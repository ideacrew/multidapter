module Multidapter
  module AsyncApi
    class SchemaFormat < Dry::Struct

      attribute :version do
        attribute :key, Types::Symbol
        attribute :value, Types::Array.of(Types::Any)
      end

    end
  end
end