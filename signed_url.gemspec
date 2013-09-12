# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'signed_url/version'

Gem::Specification.new do |spec|
  spec.name          = "signed_url"
  spec.version       = SignedUrl::VERSION
  spec.authors       = ["Robin Clart"]
  spec.email         = ["robin@clart.be"]
  spec.description   = %q{Sign URLs with a base64 encoded HMAC-SHA256 digest}
  spec.summary       = %q{Sign URLs with a base64 encoded HMAC-SHA256 digest}
  spec.homepage      = "http://github.com/robinclart/signed_url"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
