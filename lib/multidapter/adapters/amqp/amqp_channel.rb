# frozen_string_literal: true

module Multidapter
  module Adapters
    module Amqp
      class AmqpChannel < Multidapter::AsyncApi::Channel

        KINDS = [
          :queue,       # Queue
          :routing_key, # Exchange
        ]

        BINDING_OPTION_DEFAULTS = {
          is: nil,
          protocol: :amqp,
          binding_version: '0.1.0'.freeze,

          user_id: nil,       # Sender
          cc: ['user.logs'],            # message routing keys
          bcc: [],
          reply_to: 'user.signedup',      # name of queue where consumer should send response

          expiration: 100_000, # TTL
          priority: 10,
          delivery_mode: 1,   # 1 = transient, 2 = persistent
          timestamp: true,   # message should include timestamp

          # Producer only
          mandatory: false,    # message is required

          # Consumer only
          ack: false,
        }

        def initialize()
          super
        end


        def connect
          @channel_id 
        end

      end
    end
  end
end
