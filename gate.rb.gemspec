# gate.rb.gemspec

require_relative './lib/Gate/VERSION'

Gem::Specification.new do |spec|
  spec.name = 'gate.rb'
  spec.version = Gate::VERSION

  spec.summary = "Access the Gate API with Ruby."
  spec.description = "Access the Gate API with Ruby."

  spec.author = 'thoran'
  spec.email = 'code@thoran.com'
  spec.homepage = 'https://github.com/thoran/gate'
  spec.license = 'MIT'

  spec.metadata = {
    'bug_tracker_uri' => 'https://github.com/thoran/gate/issues',
    'changelog_uri' => 'https://github.com/thoran/gate/blob/master/CHANGELOG',
    'source_code_uri' => 'https://github.com/thoran/gate',
    'documentation_uri' => 'https://github.com/thoran/gate/blob/master/README.md',
  }

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
