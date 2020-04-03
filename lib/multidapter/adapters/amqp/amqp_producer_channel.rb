require 'bunny'

module Multidapter
  module Adapters
    module Amqp
      class AmqpProducerAdapter < Adapter

        EXCHANGE_KINDS = {
          default:  '',
          direct:   'amq.direct',   # Delivers messages to queues based on the message routing key
          fanout:   'amq.fanout',   # Route messages to all of the queues that are bound to it and the routing key is ignored
          topic:    'amq.topic',    # Route messages to one or many queues based on matching between a message routing key and the pattern that was used to bind a queue to an exchange
          headers:  'amq.headers',  # Route messages using multiple attributes that are more easily expressed as message headers than a routing key
        }

        OPTION_DEFAULTS = {
          name:         nil,
          vhost:        '/',
          kind:         EXCHANGE_KINDS[:default],
          durable:      true,   # Exchange survives broker restart
          exclusive:    true,   
          auto_delete:  false,  # Exchange is deleted when last queue is unbound from it
        }

        attr_reader :name, :vhost, :durable, :kind, :exclusive, :auto_delete

        def initialize(uri, options = {})
          super
          @uri = uri

          @options = OPTION_DEFAULTS.merge(options)
          @vhost        = options[:vhost]
          @kind         = options[:kind]
          @durable      = options[:durable]
          @auto_delete  = options[:auto_delete]
        end


        private

        def channel=(new_channel)
          @channel = new_channel
        end


      end
    end
  end
end
