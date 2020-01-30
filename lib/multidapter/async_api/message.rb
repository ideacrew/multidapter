# frozen_string_literal: true

module Multidapter
  module AsyncApi

    # Describes a message received on a given channel and operation
    class Message < Dry::Struct

      # @!attribute [r] headers
      # Schema definition of the application headers. Schema MUST be of type “object”.
      # It MUST NOT define the protocol headers.
      # @return [Multidapter::AsyncApi::Schema]
      attribute :headers, Multidapter::AsyncApi::Schema

      # @!attribute [r] payload
      # Definition of the message payload. It can be of any type but defaults to Schema object
      # @return [Types::Any]
      attribute :payload, Types::Any

      # @!attribute [r] correlation_id
      # Definition of the correlation ID used for message tracing or matching
      # @return [String]
      attribute :correlation_id do

        # @!attribute [r] description
        # An optional description of the identifier.
        # CommonMark syntax can be used for rich text representation
        # @return [String]
        attribute :description, Types::String

        # @!attribute [r] location
        # Required. A runtime expression that specifies the location of the correlation ID
        # @return [String]
        attribute :location,    Types::String
      end

      # @!attribute [r] schema_format
      # A string containing the name of the schema format used to define the message payload.
      # If omitted, implementations should parse the payload as a Schema object. Check out the
      # supported schema formats table for more information. Custom values are allowed but
      # their implementation is OPTIONAL. A custom value MUST NOT refer to one of the schema formats
      # listed in the table.
      # @return [String]
      attribute :schema_format, Types::String

      # @!attribute [r] content_type
      # The content type to use when encoding/decoding a message’s payload. The value MUST be a
      # specific media type (e.g. application/json). When omitted, the value MUST be the one specified
      # on the default_content_type field
      # @return [String]
      attribute :content_type,  Types::String

      # @!attribute [r] name
      # A machine-friendly name for the message
      # @return [String]
      attribute :name,          Types::String

      # @!attribute [r] title
      # A human-friendly title for the message
      # @return [String]
      attribute :title,         Types::String

      # @!attribute [r] summary
      # A short summary of what the message is about
      # @return [String]
      attribute :summary,       Types::String

      # @!attribute [r] description
      # A verbose explanation of the message. CommonMark syntax can be used for rich text representation
      # @return [String]
      attribute :description,   Types::String

      # @!attribute [r] tags
      # A list of tags for API documentation control. Tags can be used for logical grouping of messages
      # @return [Array<Multidapter::AsyncApi::Tag>]
      attribute :tags,          Types::Array.of(Multidapter::AsyncApi::Tag).meta(omittable: true)

      # @!attribute [r] description
      # Additional external documentation for this message
      # @return [Multidapter::AsyncApi::ExternalDocumentation]
      attribute :external_docs, Multidapter::AsyncApi::ExternalDocumentation

      # @!attribute [r] bindings
      # Map where the keys describe the name of the protocol and the values describe protocol-specific
      # definitions for the message
      # @return [Hash]
      attribute :bindings,      Types::Hash

      # @!attribute [r] examples
      # An array with examples of valid message objects
      # @return [Hash]
      attribute :examples,      Types::Array.of(Hash)

      # @!attribute [r] traits
      # A list of traits to apply to the message object. Traits MUST be merged into the message object
      # using the JSON Merge Patch algorithm in the same order they are defined here. The resulting
      # object MUST be a valid Message Object
      # @return [Array<Multidapter::AsyncApi::MessageTrait>]
      attribute :traits,        Types::Array.of(Multidapter::AsyncApi::MessageTrait)


    end
  end
end
