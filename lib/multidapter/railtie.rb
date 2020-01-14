# frozen_string_literal: true
# encoding: utf-8

require "rails"
require "rails/multidapter"

module Rails
  module Multidapter

    # Hooks Multidapter into Rails
    class Railtie < Rails::Railtie


      # Expose configuration to the Rails application configuration
      config.multidapter = Multidapter::Config


      # Initialize Multidapter. This will look for a multidapter.yml in the config
      # directory and configure multidapter appropriately

      initializer "multidapter.load-config" do
        config_file = Rails.root.join("config", "multidapter.yml")
        if config_file.file?
          begin
            Multidapter.load!(config_file)
          rescue Multidapter::Errors::NoClientsConfig => e
            handle_configuration_error(e)
          rescue Multidapter::Errors::NoDefaultClient => e
            handle_configuration_error(e)
          rescue Multidapter::Errors::NoClientHosts => e
            handle_configuration_error(e)
          end
        end
      end

      def handle_configuration_error(e)
        puts "There is a configuration error with the current multidapter.yml."
        puts e.message
      end

    end
  end
end
