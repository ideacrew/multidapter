require "multidapter/version"
require "multidapter/errors"

require 'uri'
require 'securerandom'

require 'dry/monads'
require 'dry/monads/result'
require 'dry/monads/do'
require 'dry-struct'

require 'multidapter/types'
# require "multidapter/log"
# require "multidapter/config/load_config"

require "multidapter/serializers/yaml"
require "multidapter/operations/operation"
require "multidapter/application"
require 'multidapter/validators/validator'
require 'multidapter/uris/amqp'


module Multidapter

    def self.generate_uuid
      SecureRandom.uuid
    end

    def self.generate_id
      generate_uuid
    end

  module ClassMethods

    # Turn on logging
    #   class Foo
    #     include HTTParty
    #     logger Logger.new('http_logger'), :info, :apache
    #   end

    # def logger(logger, level = :info, format = :apache)
    #   default_options[:logger]     = logger
    #   default_options[:log_level]  = level
    #   default_options[:log_format] = format
    # end
  end
end
