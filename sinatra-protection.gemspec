# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra/protection/version'

Gem::Specification.new do |spec|
  spec.name          = "sinatra-protection"
  spec.version       = Sinatra::Protection::VERSION
  spec.authors       = ["Adam Pohorecki"]
  spec.email         = ["adam@pohorecki.pl"]

  spec.summary       = %q{Add selective basic auth protection to your Sinatra apps}
  spec.description   = %q{Makes it possible to protect selected Sinatra routes with HTTP Basic Authentication}
  spec.homepage      = "https://github.com/gunpowderlabs/sinatra-protection"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra-contrib"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "sinatra"
end
