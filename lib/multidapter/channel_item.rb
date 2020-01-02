# frozen_string_literal: true
# “topics”, “routing keys”, “event types” or “paths”
module Multidapter
  module Adapters
    class ChannelItem

      OPTIONS_DEFAULT = {
        # Allows for an external definition of this channel item
        ref:          "",

        # An optional description of this channel item
        description:  "",

        # A definition of the SUBSCRIBE operation
        subscribe:    nil,

        # A definition of the PUBLISH operation
        publish:      nil,

        # A map of the parameters included in the channel name. 
        # It SHOULD be present only when using channels with expressions
        parameters:   {},

        # map where the keys describe the name of the protocol and the 
        # values describe protocol-specific definitions for the channel
        bindings:     {},
      }


    end
  end
end
