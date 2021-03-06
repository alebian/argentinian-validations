lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'argentinian/validations/version'

Gem::Specification.new do |spec|
  spec.name          = 'argentinian-validations'
  spec.version       = Argentinian::Validations::VERSION
  spec.authors       = ['Alejandro Bezdjian']
  spec.email         = ['alebezdjian@gmail.com']
  spec.summary       = 'Validations for Argentinian specific information'
  spec.description   = 'Validations for Argentinian specific information'
  spec.homepage      = 'https://github.com/alebian/argentinian-validations'
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'rake', '~> 13.0'
end
