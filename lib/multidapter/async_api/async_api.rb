# frozen_string_literal: true

# AsyncAPI specification
# See: https://www.asyncapi.com/docs/specifications/2.0.0/

require_relative 'external_documentation'
require_relative 'schema'
require_relative 'parameter'
require_relative 'schema_format'
require_relative 'tag'
require_relative 'component'
require_relative 'info'
require_relative 'message_trait'
require_relative 'message'
require_relative 'operation_trait'
require_relative 'operation'
require_relative 'channel_item'
require_relative 'channel'
require_relative 'security_scheme'
require_relative 'server_variable'
require_relative 'server_binding'
require_relative 'server'
require_relative 'operations/operations'
require_relative 'validators/validator'


module Multidapter
  module AsyncApi
    class AsyncApi < Dry::Struct

      # AsyncAPI spec version being used (required)
      attribute :asyncapi,      Types::String

      # identifier of the application the AsyncApi is defining
      attribute :id,            Types::String

      # metadata about the API (required)
      attribute :info,          Info

      # connection details of servers
      attribute :servers,       Types::Array.of(Server).meta(omittable: true)

      # available channels and messages for API (required)
      attribute :channels,      Types::Array.of(Channel).meta(omittable: true)

      # container for schemas for the specification
      attribute :components,    Types::Array.of(Component).meta(omittable: true)

      # list of unique tags used by spec w/additional metadata
      attribute :tags,          Types::Array.of(Tag).meta(omittable: true)

      # additional external documentation
      attribute :external_docs, Types::Array.of(ExternalDocumentation).meta(omittable: true)


    end
  end
end
