# gate.rb.gemspec

require_relative './lib/Gate/VERSION'

Gem::Specification.new do |spec|
  spec.name = 'gate.rb'
  spec.version = Gate::VERSION

  spec.summary = "Access the Gate API with Ruby."
  spec.description = "Access the Gate API with Ruby."

  spec.author = 'thoran'
  spec.email = 'code@thoran.com'
  spec.homepage = 'http://github.com/thoran/gate.rb'
  spec.license = 'MIT'

  spec.required_ruby_version = '>= 2.7'
  spec.require_paths = ['lib']

  spec.files = [
    'gate.rb.gemspec',
    Dir['lib/**/*.rb'],
    Dir['test/**/*.rb'],
    'CHANGELOG',
    'Gemfile',
    'LICENSE',
    'README.md',
  ].flatten

  spec.add_dependency('http.rb')
end
