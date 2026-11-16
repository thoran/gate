require_relative '../../../helper'

describe Gate::V4::Client do
  describe "#initialize" do
    it "takes debug as a keyword" do
      _(Gate::V4::Client.new(debug: true).debug).must_equal(true)
    end

    it "takes logger as a keyword" do
      logger = Object.new
      _(Gate::V4::Client.new(logger: logger).logger).must_be_same_as(logger)
    end

    it "defaults to no credentials, no debugging and no logger" do
      client = Gate::V4::Client.new
      _(client.api_key).must_be_nil
      _(client.api_secret).must_be_nil
      _(client.debug).must_equal(false)
      _(client.logger).must_be_nil
    end

    it "yields the client being built" do
      yielded = nil
      client = Gate::V4::Client.new do |c|
        yielded = c
        c.api_key = 'a_key'
        c.api_secret = 'a_secret'
      end
      _(yielded).must_be_same_as(client)
      _(client.api_key).must_equal('a_key')
      _(client.api_secret).must_equal('a_secret')
    end

    it "is the same for Gate::Client" do
      client = Gate::Client.new(api_key: 'a_key'){|c| c.api_secret = 'a_secret'}
      _(client.api_key).must_equal('a_key')
      _(client.api_secret).must_equal('a_secret')
    end

    it "takes the setters as well as the keywords" do
      client = Gate::V4::Client.new
      client.api_key = 'a_key'
      client.debug = true
      _(client.api_key).must_equal('a_key')
      _(client.debug).must_equal(true)
    end
  end

  describe "missing credentials" do
    let(:credentials){{api_key: 'a_key', api_secret: 'a_secret'}}

    %i{api_key api_secret}.each do |name|
      it "raises naming #{name} before anything is sent" do
        client = Gate::V4::Client.new(**credentials.reject{|k, _| k == name})
        error = _{client.wallet_total_balance}.must_raise(ArgumentError)
        _(error.message).must_equal("#{name} is missing.")
      end
    end

    it "raises naming every one missing" do
      error = _{Gate::V4::Client.new.wallet_total_balance}.must_raise(ArgumentError)
      _(error.message).must_equal('api_key, api_secret are missing.')
    end
  end

  describe "Gate" do
    it "keeps no configuration of its own" do
      %i{configure configuration configuration= reset_configuration!}.each do |name|
        _(Gate.respond_to?(name)).must_equal(false)
      end
      _(defined?(Gate::Configuration)).must_be_nil
    end
  end
end
