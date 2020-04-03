# frozen_string_literal: true
# Allows adding meta data to a single tag

module Multidapter

  # Allows adding metadata to a single tag
  class Tag < Dry::Struct

    # @!attribute [r] name
    # Tag name (required)
    # @return [Symbol]
    attribute :name,            Types::Symbol.meta(omittable: false)

    # @!attribute [r] description
    # Short description for the tag. CommonMark syntax can be used for
    # rich text representation
    # @return [String]
    attribute :description,     Types::String.meta(omittable: true)

    # @!attribute [r] external_docs
    # Additional external documentation for this tag
    # @return [Array<Multidapter::ExternalDocumentation>]
    attribute :external_docs,   Types::Array.of(Multidapter::ExternalDocumentation).meta(omittable: true)

  end
end
