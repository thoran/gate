# webmock's http_rb adapter's require 'http' finds http.rb's lib/http.rb,
# takes HTTP::VERSION for the http gem's, and crashes trying to
# monkey-patch an HTTP::Client which isn't there.
def skip_webmocks_http_rb_adapter
  gem 'webmock'

  $LOADED_FEATURES << File.join(
    Gem.loaded_specs['webmock'].full_gem_path,
    'lib/webmock/http_lib_adapters/http_rb_adapter.rb'
  )
end

skip_webmocks_http_rb_adapter

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest-spec-context'
require 'vcr'
require 'webmock'

$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))
require 'gate'

VCR.configure do |config|
  config.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  config.hook_into :webmock

  config.filter_sensitive_data('<API_KEY>'){ENV['GATE_API_KEY']}
  config.filter_sensitive_data('<API_SECRET>'){ENV['GATE_API_SECRET']}

  # Allow localhost connections for debugging
  config.ignore_localhost = true

  config.default_cassette_options = {
    record: :new_episodes,
    match_requests_on: [:method, :uri, :body]
  }
end

class Minitest::Test
  def before_setup
    super
    Gate.reset_configuration!
  end
end
