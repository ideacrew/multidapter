# frozen_string_literal: true
require "sneakers"

module Multidapter
  module Adapters
    module Amqp
      class AmqpChannelProxy
        include Sneakers::Worker

        WORKER_CONFIG_DEFAULT = {
          env:                    ENV['RACK_ENV'],  # Environment
          timeout_job_after:      5,                # Maximal seconds to wait for job
          prefetch:               1,                # Grab 10 jobs together. Better speed.
          threads:                1,                # Threadpool size (good to match prefetch)
          durable:                true,             # Is queue durable?
          ack:                    true,             # Must we acknowledge?
          heartbeat:              2,                # Keep a good connection with broker
          exchange:               EXCHANGE_DEFAULT, # AMQP exchange
          hooks:                  {},               # prefork/postfork hooks
          start_worker_delay:     10,               # Delay between thread startup
        }

        def initialize(amqp_channel)
          raise ArgumentError, "must be an AmqpChannel" unless amqp_channel.is_a? Multidapter::Adapters::Amqp::AmqpChannel

          @subject = amqp_channel
        end


        def method_missing(name, *args)
          @subject.send(name, *args)
        end

      end
    end
  end
end
