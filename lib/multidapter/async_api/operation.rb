# frozen_string_literal true
# Describes a publish or a subscribe operation on a Channel

module Multidapter
  module AsyncApi
    class Operation < Dry::Struct

      # Unique string used to identify the operation. The id MUST be unique among all operations
      # described in the API. The operationId value is case-sensitive. Tools and libraries MAY use
      # the operationId to uniquely identify an operation, therefore, it is RECOMMENDED to follow
      # common programming naming conventions
      attribute :operation_id, Types::String.meta(omittable: true)

      # short summary of what the operation is about
      attribute :summary, Types::String.meta(omittable: true)

      # verbose explanation of the operation. CommonMark syntax can be used for rich text representation
      attribute :description, Types::String.meta(omittable: true)

      # A list of tags for API documentation control. Tags can be used for logical grouping of
      # operations.
      attribute :tags, Types::Array.of(Multidapter::AsyncApi::Tag).meta(omittable: true)

      # External Documentation Object Additional external documentation for this operation.
      attribute :external_docs, Types::String.meta(omittable: true)

      # map where the keys describe the name of the protocol and the values describe protocol-specific
      # definitions for the operation.
      attribute :bindings, Types::Hash.meta(omittable: true)

      # a list of traits to apply to the operation object. Traits MUST be merged into the operation
      # object using the JSON Merge Patch algorithm in the same order they are defined here
      attribute :traits, Types::Array.of(Multidapter::AsyncApi::OperationTrait).meta(omittable: true)

      # A definition of the message that will be published or received on this channel. oneOf is
      # allowed here to specify multiple messages, however, a message MUST be valid only against one of
      # the referenced message objects
      attribute :message, Types::Array.of(Multidapter::AsyncApi::Message).meta(omittable: true)

    end
  end
end
