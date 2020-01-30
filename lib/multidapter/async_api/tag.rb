# frozen_string_literal: true
# Allows adding meta data to a single tag

module Multidapter
  module AsyncApi
    # Allows adding metadata to a single tag
    class Tag < Dry::Struct

      # @!attribute [r] name
      # Tag name (required)
      # @return [Symbol]
      attribute :name, Types::Symbol

      # @!attribute [r] description
      # short description for the tag. CommonMark syntax can be used for
      # rich text representation
      # @return [String]
      attribute :description, Types::String

      # @!attribute [r] external_docs
      # Additional external documentation for this tag
      # @return [Array<Multidapter::AsyncApi::ExternalDocumentation>]
      attribute :external_docs, Multidapter::AsyncApi::ExternalDocumentation

    end
  end
end
