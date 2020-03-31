# frozen_string_literal: true

module Multidapter

  # A relative path to an individual channel. The field name MUST be in the form of a
  # RFC 6570 URI template. Query parameters and fragments SHALL NOT be used, instead
  # use bindings to define them
  # Describes the operations available on a single channel
  class ChannelItem < Dry::Struct

    # @!attribute [r] ref
    # Allows for an external definition of this channel item. The referenced structure
    # MUST be in the format of a Channel Item Object. If there are conflicts between the
    # referenced definition and this Channel Item’s definition, the behavior is undefined.
    # @return [String]
    attribute :ref,         Types::String.meta(omittable: true)

    # @!attribute [r] description
    # An optional description of this channel item
    # @return [String]
    attribute :description, Types::String.meta(omittable: true)

    # @!attribute [r] subscribe
    # A definition of the Subscribe operation
    # @return [Operation]
    attribute :subscribe,   Operation.meta(omittable: true)

    # @!attribute [r] publish
    # A definition of the Publish operation
    # @return [Operation]
    attribute :publish,     Operation.meta(omittable: true)

    # @!attribute [r] url
    # A map of the parameters included in the channel name.
    # It SHOULD be present only when using channels with expressions
    # @return [Parameter]
    attribute :parameters,  Parameter.meta(omittable: true)

    # @!attribute [r] bindings
    # A map where the keys describe the name of the protocol and the
    # values describe protocol-specific definitions for the channel
    # @return [Hash]
    attribute :bindings,    Types::Hash.meta(omittable: true)

  end
end
