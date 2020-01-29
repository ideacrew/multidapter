# frozen_string_literal: true

module Multidapter
  module AsyncApi
    class Server < Dry::Struct

        # URL to the target host. Variable substitutions will be made when a variable is 
        # named in {brackets}. (required)
        attribute :url,               Types::Url

        # Protocol this URL supports for connection. Supported protocol include, but are not limited to: 
        # amqp, amqps, http, https, jms, kafka, kafka-secure, mqtt, secure-mqtt, stomp, stomps, ws, wss
        # (required)
        attribute :protocol,          Types::Strict::Symbol

        # Version of the protocol used for connection
        attribute :protocol_version,  Types::String.meta(omittable: true)

        # An optional string describing the host designated by the URL
        attribute :description,       Types::String.meta(omittable: true)

        # A map between a variable name and its value. The value is used for substitution in the 
        # server’s URL template.
        attribute :variables,         Types::Array.of(Multidapter::AsyncApi::Variable).meta(omittable: true)

        # A declaration of which security mechanisms can be used with this server
        attribute :security,          Multidapter::AsyncApi::SecurityScheme.meta(omittable: true)
        
        # A free-form map where the keys describe the name of the protocol and the values describe 
        # protocol-specific definitions for the server
        attribute :bindings,          Multidapter::AsyncApi::ServerBinding.meta(omittable: true)
    end
  end
end