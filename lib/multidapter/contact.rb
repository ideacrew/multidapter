# frozen_string_literal: true

module Multidapter

  # Contact information for the exposed API.
  class Contact < Dry::Struct

    # @!attribute [r] name
    # The identifying name of the contact person/organization
    # @return [String]
    attribute :name,  Types::String.optional.meta(omittable: true)

    # @!attribute [r] url
    # The URL pointing to the contact information. Must be in the format of a URL.
    # @return [String]
    attribute :url,   Types::Url.optional.meta(omittable: true)

    # @!attribute [r] email
    # The email address of the contact person/organization. Must be in the format of an email address.
    # @return [String]
    attribute :email, Types::Email.optional.meta(omittable: true)
  end
end
