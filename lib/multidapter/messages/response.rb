# frozen_string_literal: true

module Multidapter
  module Messages
    class Response

      attr_accessor :requests_queue_name, :message_id, :reply_to
      attr_reader :correlation_id

      def initialize(params, &block)

        @correlation_id = Messages.generate_uuid
      end    


      def call

        connection = AMQP.connect
        channel    = AMQP::Channel.new(connection)

        requests_queue = channel.queue("amqpgem.examples.services.time", :exclusive => true, :auto_delete => true)
        requests_queue.subscribe(:ack => true) do |metadata, payload|
          puts "[requests] Got a request #{metadata.message_id}. Sending a reply..."
          channel.default_exchange.publish(Time.now.to_s,
                                           :routing_key    => metadata.reply_to,
                                           :correlation_id => metadata.message_id,
                                           :mandatory      => true)

          metadata.ack
        end

      end


    end
  end
end