# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'analytical_value/version'

Gem::Specification.new do |spec|
  spec.name          = "analytical_value"
  spec.version       = AnalyticalValue::VERSION
  spec.authors       = ["Andrew Garshyn"]
  spec.email         = ["andrew@garshyn.com"]

  spec.summary       = "Value object pattern"
  spec.description   = "Helps to calculate reports with comparison to previous period of time"
  spec.homepage      = "https://ethicontrol.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
end
