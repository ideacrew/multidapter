# frozen_string_literal true
# Channels are also known as “topics”, “routing keys”, “event types” or “paths”
# Channel paths are relative to servers

module Multidapter
  module AsyncApi
    class Channel < Dry::Struct

      attribute :channel_id,    Types::String
      attribute :channel_item,  Multidapter::AsyncApi::ChannelItem.meta(omittable: true) 
    end
  end
end