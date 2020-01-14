# frozen_string_literal: true
# Allows adding meta data to a single tag

module Multidapter
  module AsyncApi
    class Tag < Dry::Struct

      # Tag name (required)
      attribute :name, Types::String

      # short description for the tag. CommonMark syntax can be used for
      # rich text representation
      attribute :description, Types::String

      # Additional external documentation for this tag
      attribute :external_docs, ExternalDocumentation

    end
  end
end
