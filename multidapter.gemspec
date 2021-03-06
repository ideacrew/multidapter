# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "multidapter/version"

Gem::Specification.new do |spec|
  spec.name          = "multidapter"
  spec.version       = Multidapter::VERSION
  spec.authors       = ["Dan Thomas"]
  spec.email         = ["dan@ideacrew.com"]

  spec.summary       = %q{Use various integration protocols to connect and exchange messages between services}
  spec.description   = %q{Use various integration protocols to connect and exchange messages between services}
  spec.homepage      = "https://github.com/ideacrew/multidapter"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'i18n',                     '~> 1.0'
  spec.add_dependency 'dry-types',                '~> 1.0'
  spec.add_dependency 'dry-struct',               '~> 1.0'
  spec.add_dependency 'dry-monads',               '~> 1.2'

  spec.add_dependency 'dry-validation',           '~> 1.2'
  # spec.add_dependency 'dry-transaction'#,           '~> 1.0'

  spec.add_dependency 'bunny',                    '~> 2.0'
  spec.add_dependency 'httparty',                 '~> 0.17'
  spec.add_dependency 'ox',                       '~> 2.0'
  # spec.add_dependency 'fast_jsonapi',             '~> 1.0'
  spec.add_dependency 'logging',                  '~> 2.0'
  spec.add_dependency 'logging-graylog',          '~> 1.0'
  spec.add_dependency 'gelf'#,          '~> 1.0'
  spec.add_dependency 'mime-types'

  spec.add_development_dependency "bundler",      "~> 1.17"
  spec.add_development_dependency "rake",         "~> 10.0"
  spec.add_development_dependency "rspec",        "~> 3.0"
  spec.add_development_dependency "yard",         "~> 0.9"

  # spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'pry-byebug'
end
