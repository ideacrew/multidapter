# frozen_string_literal: true

module Multidapter
  module AsyncApi
    class Info < Dry::Struct

      # @!attribute [r] title
      # Title of the application (required)
      # @return [String]
      attribute :title,             Types::String

      # @!attribute [r] version
      # Version of the application API (required)
      # @return [String]
      attribute :version,           Types::String.default(Multidapter::VERSION.freeze)

      # @!attribute [r] description
      # A short description of the application
      # @return [String]
      attribute :description,       Types::String.optional.meta(omittable: true)

      # @!attribute [r] terms_of_service
      # URL to the Terms of Service for the API. MUST be in the format of a URL
      # @return [Types::Url]
      attribute :terms_of_service,  Types::Url.optional.meta(omittable: true)

      # @!attribute [r] contact
      # Contact information for the exposed API
      # @return [Hash{ :name => String, :url => Types::Url, :email => Types::Email }]
      attribute :contact do
        attribute :name,  Types::String
        attribute :url,   Types::Types::Url
        attribute :email, Types::Email
      end

      # @!attribute [r] license
      # License information for the exposed API
      # @return [Hash{ :name => String, :url => Types::Url }]
      attribute :license do
        attribute :name,  Types::String
        attribute :url,   Types::Types::Url
      end

    end
  end
end
