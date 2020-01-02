# frozen_string_literal true
# Channels are also known as “topics”, “routing keys”, “event types” or “paths”
# Channel paths are relative to servers

module Multidapter
  module AsyncApi
    class Channel < Dry::Struct

      # A relative path to an individual channel. The field name MUST be in the form of a 
      # RFC 6570 URI template. Query parameters and fragments SHALL NOT be used, instead 
      # use bindings to define them
      attribute :path, Types::String

      # Describes the operations available on a single channel
      attribute :channel, Multidapter::AsyncApi::ChannelItem

    end
  end
end