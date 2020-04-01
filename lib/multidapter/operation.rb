# frozen_string_literal true
# Describes a publish or a subscribe operation on a Channel

module Multidapter

  # Describes a publish or a subscribe operation. This provides a place to document how and
  # why messages are sent and received. For example, an operation might describe a chat application
  # use case where a user sends a text message to a group
  class Operation < Dry::Struct

    # @!attribute [r] operation_id
    # Unique string used to identify the operation. The id MUST be unique among all operations
    # described in the API. The operationId value is case-sensitive. Tools and libraries MAY use
    # the operationId to uniquely identify an operation, therefore, it is RECOMMENDED to follow
    # common programming naming conventions
    # @return [String]
    attribute :operation_id, Types::Symbol.meta(omittable: true)

    # @!attribute [r] summary
    # Short summary of what the operation is about
    # @return [String]
    attribute :summary, Types::String.meta(omittable: true)

    # @!attribute [r] description
    # Verbose explanation of the operation. CommonMark syntax can be used for rich text representation
    # @return [String]
    attribute :description, Types::String.meta(omittable: true)

    # @!attribute [r] tags
    # A list of tags for API documentation control. Tags can be used for logical grouping of
    # operations.
    # @return [Array<Multidapter::Tag>]
    attribute :tags, Types::Array.of(Multidapter::Tag).meta(omittable: true)

    # @!attribute [r] external_docs
    # External Documentation Object Additional external documentation for this operation.
    # @return [Array<Multidapter::ExternalDocumentation>]
    attribute :external_docs, Types::Array.of(Multidapter::ExternalDocumentation).meta(omittable: true)

    # @!attribute [r] bindings
    # Map where the keys describe the name of the protocol and the values describe protocol-specific
    # definitions for the operation.
    # @return [Hash]
    attribute :bindings, Types::Hash.meta(omittable: true)

    # @!attribute [r] traits
    # A list of traits to apply to the operation object. Traits MUST be merged into the operation
    # object using the JSON Merge Patch algorithm in the same order they are defined here
    # @return [Array<Multidapter::OperationTrait>]
    attribute :traits, Types::Array.of(Multidapter::OperationTrait).meta(omittable: true)

    # @!attribute [r] message
    # A definition of the message that will be published or received on this channel. oneOf is
    # allowed here to specify multiple messages, however, a message MUST be valid only against one of
    # the referenced message objects
    # @return [Multidapter::Message]
    attribute :message, Multidapter::Message.meta(omittable: true)

  end
end
