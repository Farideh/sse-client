# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sse/client/version'

Gem::Specification.new do |spec|
  spec.name          = "sse-client"
  spec.version       = Sse::Client::VERSION
  spec.authors       = ["Hossein Bukhamseen"]
  spec.email         = ["bukhamseen.h@gmail.com"]
  spec.description   = %q{A client for sse-server to push events. }
  spec.summary       = %q{push events to sse-server}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "redis"
  spec.add_dependency "json"
  spec.add_dependency "connection_pool"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", '~> 4.2'
end
