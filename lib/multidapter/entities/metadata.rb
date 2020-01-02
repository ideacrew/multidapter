module Multidapter
  module Entities
    class Metadata < Dry::Struct

      attribute :id, Types::String
      attribute :reply_to, Types::String
      attribute :time, Types::Time
      attribute :schema_version, Types::String

    end
  end
end
