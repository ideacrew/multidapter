# frozen_string_literal: true

module Multidapter

  # The identifying name of the contact person/organization
  class License < Dry::Struct

    # @!attribute [r] name
    # The license name used for the API (required)
    # @return [String]
    attribute :name,  Types::String.optional.meta(omittable: true)

    # @!attribute [r] url
    # A URL to the license used for the API. Must be in the format of a URL.
    # @return [String]
    attribute :url,   Types::Url.optional.meta(omittable: true)
  end
end
