# frozen_string_literal true

module Multidapter
  module AsyncApi
    
    # Holds the relative paths to the individual channel and their operations. Channel 
    # paths are relative to servers.
    # Channels are also known as “topics”, “routing keys”, “event types” or “paths”
    class Channel < Dry::Struct

      # @!attribute [r] channel_id
      # An identifier for this Channel
      # @return [String]
      attribute :channel_id,    Types::String

      # @!attribute [r] channel_item
      # A relative path to an individual channel. The field name MUST be in the form of a 
      # RFC 6570 URI template. Query parameters and fragments SHALL NOT be used, instead use 
      # bindings to define them
      # @return [ChannelItem]
      attribute :channel_item,  ChannelItem.meta(omittable: true)
    end
  end
end
