# frozen_string_literal: true
# Describes a trait that MAY be applied to an Operation object

module Multidapter
  module AsyncApi
    class OperationTrait < Dry::Struct

      # Unique string used to identify the operation. The id MUST be unique among all operations
      # described in the API. The operationId value is case-sensitive. Tools and libraries MAY use
      # the operationId to uniquely identify an operation, therefore, it is RECOMMENDED to follow
      # common programming naming conventions
      attribute :operation_id,  Types::String

      # short summary of what the operation is about
      attribute :summary,       Types::String

      # verbose explanation of the operation. CommonMark syntax can be used for rich text representation
      attribute :description,   Types::String

      # A list of tags for API documentation control. Tags can be used for logical grouping of
      # operations.
      attribute :tags,          Types::Array.of(Multidapter::AsyncApi::Tag).meta(omittable: true)

      # External Documentation Object Additional external documentation for this operation.
      attribute :external_docs, Types::String

      # map where the keys describe the name of the protocol and the values describe protocol-specific
      # definitions for the operation.
      attribute :bindings,      Types::Hash


    end
  end
end
