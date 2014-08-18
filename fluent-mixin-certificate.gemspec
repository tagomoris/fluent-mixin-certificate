# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "fluent-mixin-certificate"
  spec.version       = "0.0.2"
  spec.authors       = ["TAGOMORI Satoshi"]
  spec.email         = ["tagomoris@gmail.com"]
  spec.summary       = %q{Fluentd mixin module to provide certificate/key generation/handling}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/tagomoris/fluent-mixin-certificate"
  spec.license       = "APLv2"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "fluentd"
  spec.add_runtime_dependency "fluent-mixin-config-placeholders", ">= 0.3.0"
end
