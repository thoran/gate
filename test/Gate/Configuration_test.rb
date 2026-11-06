require_relative '../helper'

describe Gate::Configuration do
  describe "#initialize" do
    it "sets default values" do
      config = Gate::Configuration.new
      _(config.api_key).must_be_nil
      _(config.api_secret).must_be_nil
      _(config.debug).must_equal(false)
    end
  end

  describe "#configure" do
    it "yields the configuration" do
      config = Gate::Configuration.new
      config.configure{|c| c.api_key = 'a_key'}
      _(config.api_key).must_equal('a_key')
    end
  end
end
