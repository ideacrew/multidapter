# frozen_string_literal: true

module Multidapter
  class Component < Dry::Struct

    attribute :field_name, Types::ComponentTypes
    # attribute :component, Types::Hash do
    # end

  end
end
