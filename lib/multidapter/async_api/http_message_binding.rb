# frozen_string_literal: true
# This object contains information about the message representation in HTTP

module Multidapter
  module AsyncApi
    class HttpMessageBinding < Dry::Struct

      # A Schema object containing the definitions for HTTP-specific headers. 
      # This schema MUST be of type object and have a properties key.
      attribute :headers,  Multidapter::AsyncApi::Schema

      # The version of this binding. If omitted, "latest" MUST be assumed
      attribute :binding_version, Type::String

    end
  end
end
