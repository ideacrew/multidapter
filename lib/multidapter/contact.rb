# frozen_string_literal: true

module Multidapter
  class Contact < Dry::Struct

      attribute :name,  Types::String.optional.meta(omittable: true)
      attribute :url,   Types::Url.optional.meta(omittable: true)
      attribute :email, Types::Email.optional.meta(omittable: true)
  end
end
