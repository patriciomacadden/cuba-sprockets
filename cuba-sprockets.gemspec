# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'cuba-sprockets'
  spec.version       = '0.2.0'
  spec.authors       = ['Patricio Mac Adden']
  spec.email         = ['patriciomacadden@gmail.com']
  spec.summary       = %q{Sprockets plugin for Cuba.}
  spec.description   = %q{Sprockets plugin for Cuba.}
  spec.homepage      = 'https://github.com/patriciomacadden/cuba-sprockets'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'oktobertest'

  spec.add_runtime_dependency 'cuba', '~> 3.3'
  spec.add_runtime_dependency 'sprockets', '~> 3.0.0.beta.0'
end
