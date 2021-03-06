# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oembedder/version'

Gem::Specification.new do |spec|
  spec.name          = "oembedder"
  spec.version       = Oembedder::VERSION
  spec.authors       = ["k0uki"]
  spec.email         = ["k0uki221@gmail.com"]
  spec.summary       = "An oEmbed consumer library"
  spec.description   = "An oEmbed consumer library"
  spec.homepage      = "https://github.com/k0uki/oembedder"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
