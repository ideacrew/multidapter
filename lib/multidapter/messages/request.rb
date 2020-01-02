# frozen_string_literal: true

module Multidapter
  module Messages
    class Request

      QueueOptions = {:exclusive => true, :auto_delete => true}

      connection = AMQP.connect
      channel    = AMQP::Channel.new(connection)


      attr_writer :routing_key, :reply_to_queue_name
      attr_reader :correlation_id

      def initialize(params, &block)

        @reply_to_queue = channel.queue()
        @message_id = Messages.generate_uuid
        @correlation_id = Messages.generate_uuid
      end    

      def reply_to_queue_name
      end

      def reply_to_queue=(queue_name = "", options = {})
        @reply_to_queue = channel.queue(queue_name, QueueOptions.merge(options))
      end

      def send
        channel.default_exchange.publish("get.time",
                                         routing_key: @routing_key,
                                         message_id:  @message_id,
                                         reply_to:    @reply_to_queue.name)
      end

      def subscribe
        @reply_to_queue.subscribe do |metadata, payload|
          puts "[response] Response for #{metadata.correlation_id}: #{payload.inspect}"
        end
      end


    replies_queue = { name: "", exclusive: true, auto_delete: true }



    puts "[request] Sending a request..."





    end
  end
end