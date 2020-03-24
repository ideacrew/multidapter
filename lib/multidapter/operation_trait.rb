# frozen_string_literal: true
# Describes a trait that MAY be applied to an Operation object

module Multidapter

  # Describes a trait that MAY be applied to an Operation Object. This object MAY contain any property from
  # the Operation Object, except message and traits.
  class OperationTrait < Dry::Struct

    # @!attribute [r] operation_id
    # Unique string used to identify the operation. The id MUST be unique among all operations
    # described in the API. The operationId value is case-sensitive. Tools and libraries MAY use
    # the operationId to uniquely identify an operation, therefore, it is RECOMMENDED to follow
    # common programming naming conventions
    # @return [String]
    attribute :operation_id,  Types::String

    # @!attribute [r] summary
    # Short summary of what the operation is about
    # @return [String]
    attribute :summary,       Types::String

    # @!attribute [r] description
    # Verbose explanation of the operation. CommonMark syntax can be used for rich text representation
    # @return [String]
    attribute :description,   Types::String

    # @!attribute [r] tags
    # A list of tags for API documentation control. Tags can be used for logical grouping of
    # operations.
    # @return [String]
    attribute :tags,          Types::Array.of(Multidapter::Tag).meta(omittable: true)

    # @!attribute [r] external_docs
    # External Documentation Object Additional external documentation for this operation.
    # @return [String]
    attribute :external_docs, Types::String

    # @!attribute [r] bindings
    # Map where the keys describe the name of the protocol and the values describe protocol-specific
    # definitions for the operation.
    # @return [Hash]
    attribute :bindings,      Types::Hash


  end
end
