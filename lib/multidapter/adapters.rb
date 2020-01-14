# frozen_string_literal: true

require "multidapter/adapters/adapter"
require "multidapter/adapters/amqp/amqp_adapter"
require "multidapter/adapters/http/http_adapter"

module Multidapter
  module Adapters

    def self.adapters
      @adapters ||= {
        amqp:   AmqpAdapter,
        http:   HttpAdapter,
        https:  HttpAdapter,
      }
    end

    def self.add_adapter(key, adapter)
      raise Multidapter::Errors::DuplicateAdapterError("#{key} adapter already exists") if adapters.include?(key)
      adapters.merge!(name.to_sym => adapter)
    end

    def self.build(adapter, uri, options = {})
      adapter_klass = adapters[adapter]
      adapter_klass.new(uri, options)
    end

  end
end