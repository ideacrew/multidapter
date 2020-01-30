# frozen_string_literal: true
# encoding: utf-8

module Multidapter
  module Config

    # Encapsulates logic for getting environment information.
    module Environment
      extend self

      # Get the name of the environment that Multidapter is running under.
      #
      # Uses the following sources in order:
      # - If +::Rails+ is defined, +Rails.env+.
      # - +RACK_ENV+
      # - +MULTIDAPTER_ENV+
      #
      # @return [ String ] The name of the current environment.
      #
      # @example Get the env name.
      #   Environment.env_name
      #
      # @raise [ Errors::NoEnvironment ] If environment name cannot be
      #   determined because none of the sources was set.
      def env_name
        return ::Rails.env if defined?(::Rails)
        ENV["RACK_ENV"] || ENV["Multidapter_ENV"] or raise Errors::NoEnvironment
      end

      # Load the yaml from the provided path and return the settings for the
      # specified environment, or for the current Multidapter environment.
      # @param [ String ] path The location of the file.
      # @param [ String | Symbol ] environment Optional environment name to
      #   override the current Multidapter environment.
      # @return [ Hash ] The settings.
      # 
      # @example Load the yaml.
      #   Environment.load_yaml("/work/multidapter.yml")
      def load_yaml(path, environment = nil)
        env = environment ? environment.to_s : env_name
        YAML.load(ERB.new(File.new(path).read).result)[env]
      end
    end
  end
end
