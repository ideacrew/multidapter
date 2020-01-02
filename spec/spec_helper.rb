require "bundler/setup"
require "multidapter"
require 'rspec/logging_helper'
require 'pry'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Support logging output
  # include RSpec::LoggingHelper
  # config.capture_log_messages

end
