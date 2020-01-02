module Multidapter
  module Servers
    class Server < Dry::Struct

        # URL to the target host. Variable substitutions will be made when a variable is 
        # named in {brackets}. (required)
        attribute :url, Types::Url

        # protocol this URL supports for connection. Supported protocol include, but are not limited to: 
        # amqp, amqps, http, https, jms, kafka, kafka-secure, mqtt, secure-mqtt, stomp, stomps, ws, wss
        # (required)
        attribute :protocol, Types::Symbol

        # version of the protocol used for connection
        attribute :protocol_version, Types::String

        # An optional string describing the host designated by the URL
        attribute :description, Types::String

        # A map between a variable name and its value. The value is used for substitution in the 
        # server’s URL template.
        attribute :variables,  Types::Hash

        # A declaration of which security mechanisms can be used with this server
        attribute :security, Multidapter::Securities::Security

        # A free-form map where the keys describe the name of the protocol and the values describe 
        # protocol-specific definitions for the server
        attribute :bindings,  Types::Hash
    end
  end
end