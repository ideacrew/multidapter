# frozen_string_literal: true

# AsyncAPI specification
# See: https://www.asyncapi.com/docs/specifications/2.0.0/

require_relative 'external_documentation'
require_relative 'schema'
require_relative 'parameter'
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
require_relative 'variable'
require_relative 'server_binding'
require_relative 'server'


module Multidapter
  class Adapter < Dry::Struct

    # @!attribute [r] asyncapi
    # AsyncAPI spec version being used (required)
    # @return [String]
    attribute :asyncapi,      Types::String.meta(omittable: false)

    # @!attribute [r] id
    # identifier of the application the AsyncApi is defining
    # @return [String]
    attribute :id,            Types::String.meta(omittable: true)

    # @!attribute [r] info
    # metadata about the API (required)
    # @return [Info]
    attribute :info,          Info.meta(omittable: false)

    # @!attribute [r] servers
    # connection details of servers
    # @return [Array<Server>]
    attribute :servers,       Types::Array.of(Server).meta(omittable: true)

    # @!attribute [r] channels
    # available channels and messages for API (required)
    # @return [Array<Channel>]
    attribute :channels,      Types::Array.of(Channel).meta(omittable: false)

    # @!attribute [r] components
    # container for schemas for the specification
    # @return [Array<Component>]
    attribute :components,    Types::Array.of(Component).meta(omittable: true)

    # @!attribute [r] tags
    # list of unique tags used by spec w/additional metadata
    # @return [Array<Tag>]
    attribute :tags,          Types::Array.of(Tag).meta(omittable: true)

    # @!attribute [r] external_docs
    # additional external documentation
    # @return [Array<ExternalDocumentation>]
    attribute :external_docs, Types::Array.of(ExternalDocumentation).meta(omittable: true)


  end
end
