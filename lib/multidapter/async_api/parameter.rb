module Multidapter
  module AsyncApi
    class Parameter < Dry::Struct

      # A verbose explanation of the parameter. CommonMark syntax can be used for 
      #   rich text representation
      attribute :description,   Types::String

      # Definition of the parameter
      attribute :schema, Multidapter::AsyncApi::Schema

      # A runtime expression that specifies the location of the parameter value. 
      #   Even when a definition for the target field exists, it MUST NOT be used to 
      #   validate this parameter but, instead, the schema property MUST be used.
      attribute :location, Types::String

    end
  end
end