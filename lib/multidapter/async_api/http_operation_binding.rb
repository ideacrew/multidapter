# frozen_string_literal: true

module Multidapter
  module AsyncApi
    class HttpOperationBinding < Dry::Struct

# Required. Type of operation. Its value MUST be either :request or :response
attribute :type, Types::HttpOperationType

# When type is request, this is the HTTP method, otherwise it MUST be ignored. 
# Its value MUST be one of GET, POST, PUT, PATCH, DELETE, HEAD, OPTIONS, CONNECT, and TRACE
attribute :method, Types::HttpMethod

A Schema object containing the definitions for each query parameter. 
This schema MUST be of type object and have a properties key.
attribute :query , Multidapter::AsyncApi::Schema

      # Publish, Subscribe  The version of this binding. If omitted, "latest" MUST be assumed
      attribute :binding_version, Types::String
    end
  end
end