# frozen_string_literal: true

# Command Recipient
# See: http://rubyamqp.info/articles/patterns_and_use_cases/






request  = {correlation_id: "", reply_to_queue_name: ""}



response = {correlation_id: "", routing_key: "request_reply_to_queue_name"}



MessagePatterns = [
                    :event_producer,
                    :event_consumer,
                    :command_producer,
                    :command_consumer,
                    :request,
                    :response,
                    :routing_slip,
            ]


transport

message = Message.new
protocol = :amqp


event
command
request
response

enterprise_log_service = Multidapter::Protocols::Amqp::EventService.new(channel, :log_exchange)
enterprise_log_service.log(syslog_message)

enterprise_event_service = Multidapter::Protocols::Amqp::EventService.new(channel, :event_exchange)


enterprise_event = Amqp::Event.new
result = enterprise_event.publish(message, options)


producer = Amqp::ProducerFactory.new(channel, exchange)
producer.publish(message, options = {}) # @exchange.publish(messsage, options)


consumer_proxy = Amqp::ConsumerFactory.new
consumer_proxy.handle_message(metadata, payload)
consumer_proxy.start

worker = Amqp::WorkerFactory.new(channel, queue_name, consumer, options = {retry_count: 5, retry_delay: :exponential_backoff} )
worker.start



module Multidapter
  module Messages
    class CommandConsumer

      attr_accessor :command_name, :queue_name

      def initialize(params, &block)

      end    


    end
  end
end