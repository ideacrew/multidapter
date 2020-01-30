# frozen_string_literal: true

module Multidapter
  module AsyncApi
    class Component < Dry::Struct

      attribute :field_name, Types::ComponentTypes

    end
  end
end