# frozen_string_literal: true

module Multidapter
  module Adapters
    module Amqp
      class Exchange

        EXCHANGE_KINDS = [
          :topic,
        ]

        OPTION_DEFAULTS = {
          vhost: '/',
          kind: :topic,
          durable: true,
          auto_delete: false,
        }

        # attr_reader :name, OPTION_DEFAULTS.keys #:vhost, :durable, :kind, :exclusive, :auto_delete

        def self.call(name, options = {})
          new(uri, options).connection
        end

        def initialize(name, options = {})
          @name = name

          @options = OPTION_DEFAULTS.merge(options)
          @vhost        = options[:vhost]
          @kind         = options[:kind]
          @durable      = options[:durable]
          @auto_delete  = options[:auto_delete]
        end
        

        def publish(message)
          
        end

      end
    end
  end
end
