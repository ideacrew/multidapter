# frozen_string_literal: true
# Describes the operations available on a single channel



module Multidapter
  module AsyncApi
    class ChannelItem < Dry::Struct

        # Allows for an external definition of this channel item
        attribute :ref,         Types::String

        # An optional description of this channel item
        attribute :description, Types::String

        # A definition of the SUBSCRIBE operation
        attribute :subscribe,   Multidapter::AsyncApi::Operation

        # A definition of the PUBLISH operation
        attribute :publish,     Multidapter::AsyncApi::Operation

        # A map of the parameters included in the channel name. 
        # It SHOULD be present only when using channels with expressions
        attribute :parameters,  Types::Hash

        # map where the keys describe the name of the protocol and the 
        # values describe protocol-specific definitions for the channel
        attribute :bindings,    Types::Hash

    end
  end
end