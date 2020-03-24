# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'yard'

YARD::Rake::YardocTask.new do |t|
  # t.files   = ['lib/**/*.rb', OTHER_PATHS]   # optional
  # t.options = ['--any', '--extra', '--opts'] # optional
  # t.stats_options = ['--list-undoc']         # optional
  OTHER_PATHS = %w()
  t.files     = ['lib/**/*.rb', OTHER_PATHS]
  t.options   = %w('--readme', '--main=README.md', '--any', '--extra', '--opts')
  t.stats_options = ['--list-undoc']         # optional
end

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
