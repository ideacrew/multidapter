# frozen_string_literal: true
require "sneakers"

module Multidapter
  module Adapters
    module Amqp
      class AmqpConsumerAdapter < Adapter

        OPTION_DEFAULTS = {
          vhost: '/',
          exclusive: true,
          durable: true,
          auto_delete: false,
        }

        attr_reader :name, :vhost, :durable, :exclusive, :auto_delete

        def initialize(name, options = {})
          @name = name

          @options = OPTION_DEFAULTS.merge(options)
          @vhost        = options[:vhost]
          @durable      = options[:durable]
          @exclusive    = options[:exclusive]
          @auto_delete  = options[:auto_delete]

        end

      end
    end
  end
end
