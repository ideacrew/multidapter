# frozen_string_literal: true
# Allows referencing an external resource for extended documentation

module Multidapter
  module AsyncApi
    class ExternalDocumentation < Dry::Struct

      # short description for the target documentation. CommonMark syntax can be used for
      # rich text representation
      attribute :description,    Types::String

      # URL for the target documentation
      attribute :url,  Types::String

    end
  end
end
