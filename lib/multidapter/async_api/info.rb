# frozen_string_literal: true

module Multidapter
  module AsyncApi
    class Info < Dry::Struct

      # Title of the application (required)
      attribute :title,             Types::String

        # version of the application API (required)
      attribute :version,           Types::String.default(Multidapter::VERSION.freeze)

        # a short description of the application
      attribute :description,       Types::String.optional.meta(omittable: true)

        # URL to the Terms of Service for the API. MUST be in the format of a URL
      attribute :terms_of_service,  Types::Url.optional.meta(omittable: true)

        # contact information for the exposed API
      attribute :contact do
        attribute :name,  Types::String
        attribute :url,   Types::String
        attribute :email, Types::Email
      end

        # license information for the exposed API
      attribute :license do
        attribute :name,  Types::String
        attribute :url,   Types::String
      end

    end
  end
end
