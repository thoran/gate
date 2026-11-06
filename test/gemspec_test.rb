require_relative './helper'

describe 'gate.rb.gemspec' do
  let(:spec){Gem::Specification.load(File.expand_path('../gate.rb.gemspec', __dir__))}

  it "is a valid specification" do
    _(spec.validate).must_equal(true)
  end

  it "is named gate.rb" do
    _(spec.name).must_equal('gate.rb')
  end

  it "does not pin a date" do
    _(spec.date).must_equal(Gem::Specification.new.date)
  end

  it "takes its version from Gate::VERSION" do
    _(spec.version.to_s).must_equal(Gate::VERSION)
  end

  it "declares its runtime dependencies" do
    _(spec.runtime_dependencies.map(&:name).sort).must_equal(%w{http.rb})
  end

  it "ships the gemspec which names it" do
    _(spec.files).must_include('gate.rb.gemspec')
  end

  it "links the homepage and each metadata link to the repository" do
    links = [spec.homepage] + spec.metadata.values
    _(spec.metadata.keys.sort).must_equal(%w{bug_tracker_uri changelog_uri documentation_uri source_code_uri})
    links.each{|link| _(link).must_match(%r{\Ahttps://github\.com/thoran/gate(/|\z)})}
  end
end
