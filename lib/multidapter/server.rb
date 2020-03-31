# frozen_string_literal: true

module Multidapter

  # Domain entity for Server: an object representing a message broker, a server or any other kind of
  # computer program capable of sending and/or receiving data. 
  # This object captures details such as URIs, protocols and security configuration. 
  # Variable substitution can be used so that some details, for example usernames and passwords, 
  # can be injected by code generation tools.
  class Server < Dry::Struct

    # @!attribute [r] url
    # URL to the target host (required). Variable substitutions will be made when a variable is
    # enclosed in braces ({}).
    # @return [Types::Url]
    attribute :url,               Types::Url.meta(omittable: false)

    # @!attribute [r] protocol
    # Protocol this URL supports for connection. Supported protocol include, but are not limited to:
    # amqp, amqps, http, https, jms, kafka, kafka-secure, mqtt, secure-mqtt, stomp, stomps, ws, wss
    # (required)
    # @return [Symbol]
    attribute :protocol,          Types::Strict::Symbol.meta(omittable: false)

    # @!attribute [r] protocol_version
    # Version of the protocol used for connection
    # @return [String]
    attribute :protocol_version,  Types::String.meta(omittable: true)

    # @!attribute [r] description
    # An optional string describing the host designated by the URL
    # @return [String]
    attribute :description,       Types::String.meta(omittable: true)

    # @!attribute [r] variables
    # A map between a variable name and its value. The value is used for substitution in the
    # server’s URL template.
    # @return [Array<Variable>]
    attribute :variables,         Types::Array.of(Variable).meta(omittable: true)

    # @!attribute [r] security
    # A declaration of which security mechanisms can be used with this server
    # @return [SecurityScheme]
    attribute :security,          SecurityScheme.meta(omittable: true)

    # @!attribute [r] bindings
    # A free-form map where the keys describe the name of the protocol and the values describe
    # protocol-specific definitions for the server
    # @return [ServerBinding]
    attribute :bindings,          ServerBinding.meta(omittable: true)

  end
end
