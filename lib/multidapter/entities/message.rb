# Structure for packaging command and event informtion to exchange between system components
# Message design has s are purposefully 
# Includes a header with 

module Multidapter
  module Entities
    class Message < Dry::Struct

      attribute :header,      Types::Hash.meta(omittable: false).default({}) do
        attribute :id,          Types::String.meta(omittable: false)
      end
      attribute :meta,        Types::Hash.meta(omittable: true).default({})
      attribute :body,        Types::Any.optional.meta(omittable: true)
      attribute :attachments, Types::Array.meta(omittable: true).default([]) do
        attribute :attachment,  Types::Any.meta(omittable: false)
      end

    end
  end
end
