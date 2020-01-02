# frozen_string_literal: true
# Describes a trait that MAY be applied to a Message Object. This object MAY contain any property 
# from the Message Object, except payload and traits

module Multidapter
  module AsyncApi
    class MessageTrait < Dry::Struct

      # Schema definition of the application headers. Schema MUST be of type “object”.
      # It MUST NOT define the protocol headers.
      attribute :headers, Multidapter::AsyncApi::Schema

      # Definition of the correlation ID used for message tracing or matching
      attribute :correlation_id do

        # An optional description of the identifier.
        # CommonMark syntax can be used for rich text representation
        attribute :description, Types::String

        # Required. A runtime expression that specifies the location of the correlation ID
        attribute :location,    Types::String
      end

      # A string containing the name of the schema format used to define the message payload.
      # If omitted, implementations should parse the payload as a Schema object. Check out the
      # supported schema formats table for more information. Custom values are allowed but
      # their implementation is OPTIONAL. A custom value MUST NOT refer to one of the schema formats
      # listed in the table.
      attribute :schema_format, Types::String

      # The content type to use when encoding/decoding a message’s payload. The value MUST be a
      # specific media type (e.g. application/json). When omitted, the value MUST be the one specified
      # on the default_content_type field
      attribute :content_type,  Types::String

      # A machine-friendly name for the message
      attribute :name,          Types::String

      # A human-friendly title for the message
      attribute :title,         Types::String

      # A short summary of what the message is about
      attribute :summary,       Types::String

      # A verbose explanation of the message. CommonMark syntax can be used for rich text representation
      attribute :description,   Types::String

      # A list of tags for API documentation control. Tags can be used for logical grouping of messages
      attribute :tags,          Types::Array.of(Multidapter::AsyncApi::Tag).meta(omittable: true)

      # Additional external documentation for this message
      attribute :external_docs, Multidapter::AsyncApi::ExternalDocumentation

      # map where the keys describe the name of the protocol and the values describe protocol-specific
      # definitions for the message
      attribute :bindings,      Types::Hash

      # An array with examples of valid message objects
      attribute :examples,      Types::Array.of(Hash)

    end
  end
end
