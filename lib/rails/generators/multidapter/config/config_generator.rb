# frozen_string_literal: true
# encoding: utf-8

require 'rails/generators/multidapter_generator'

module Multidapter
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      desc "Creates a Multidapter configuration file at config/multidapter.yml"

      argument :database_name, type: :string, optional: true

      def self.source_root
        @_multidapter_source_root ||= File.expand_path("../templates", __FILE__)
      end

      def app_name
        Rails::Application.subclasses.first.parent.to_s.underscore
      end

      def create_config_file
        template 'multidapter.yml', File.join('config', "multidapter.yml")
      end

    end
  end
end
